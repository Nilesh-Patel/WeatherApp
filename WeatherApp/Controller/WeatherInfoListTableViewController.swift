//
//  WeatherInfoListTableViewController.swift
//  WeatherApp
//
//  Created by Nilesh Patel on 16/02/17.
//  Copyright © 2017 MIT Agency. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift

class WeatherInfoListTableViewController: UITableViewController {
    
    //MARK:- Var 
    var weatherArray = [WeatherObject]()
    var selectedWeatherObject : WeatherObject?

    //MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        
        let nc = NotificationCenter.default // Note that default is now a property, not a method call
        nc.addObserver(forName:Notification.Name(rawValue:"internetCheck"),
                       object:nil, queue:nil) {
                        notification in
                        self.callAPI()
        }

        self.title = "Weather"
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(WeatherInfoListTableViewController.callAPI), userInfo: nil, repeats: false)
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        // Configure the cell...

        let obj = self.weatherArray[indexPath.row]
        cell.textLabel?.text = obj.name
        cell.detailTextLabel?.text = String(describing: obj.main?.temp ?? 0.0) + " °C"
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedWeatherObject = self.weatherArray[indexPath.row]
        self.performSegue(withIdentifier: "WeatherDetailVC", sender: self)
    }

    
    //MARK: - API
    func callAPI(){
        // Check Internet Connection
        if(Utility.isInternetAvailable()){
            self.getWeatherData()
        }else{
            self.view.makeToast("Please check your internet connection")
        }
    }

    func getWeatherData(){
        LoadingIndicatorView.show(overlayTarget: self.view, loadingText: nil, position: .Top)
        Alamofire.request(AppConstants.API_EndPoint, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                LoadingIndicatorView.hide()
                if let error = response.result.error {
                    print(error)
                }else{
                    guard let json = response.result.value as? [String: AnyObject] else {
                        print("Not proper JSON Object")
                        return
                    }
                    if let buf = json["list"] as? [AnyObject] {
                        self.weatherArray.removeAll()
                        buf.forEach({ (item) in
                            self.weatherArray.append(WeatherObject(object: item))
                        })
                        let range = NSMakeRange(0, self.tableView.numberOfSections)
                        let indexSet = NSIndexSet(indexesIn: range)
                        self.tableView.reloadSections(indexSet as IndexSet, with: UITableViewRowAnimation.automatic)
                    }
                }
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "WeatherDetailVC" {
            if let destination = segue.destination as? WeatherDetailTableViewController {
                destination.weatherInfo = self.selectedWeatherObject
            }
        }
    }
}
