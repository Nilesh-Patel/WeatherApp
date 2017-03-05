//
//  WeatherDetailTableViewController.swift
//  WeatherApp
//
//  Created by Nilesh Patel on 16/02/17.
//  Copyright © 2017 MIT Agency. All rights reserved.
//

import UIKit

class WeatherDetailTableViewController: UITableViewController {

    //MARK: - @IBOutlet
    @IBOutlet weak var temp : UILabel?
    @IBOutlet weak var minTemp : UILabel?
    @IBOutlet weak var maxTemp : UILabel?
    @IBOutlet weak var humidity : UILabel?
    @IBOutlet weak var pressure : UILabel?
    
    //MARK: - var
    var weatherInfo : WeatherObject?
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.alpha = 1.0
        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
        self.title = weatherInfo?.name
        self.showWeatherInfo()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Pulic function
    func showWeatherInfo(){
        self.temp?.text = String(describing: weatherInfo?.main?.temp ?? 0.0) + " °C"
        self.minTemp?.text = String(describing: weatherInfo?.main?.tempMin ?? 0.0) + " °C"
        self.maxTemp?.text = String(describing: weatherInfo?.main?.tempMax ?? 0.0) + " °C"
        self.pressure?.text = String(describing: weatherInfo?.main?.pressure ?? 0.0) + " mb"
        self.humidity?.text = String(describing: weatherInfo?.main?.humidity ?? 0) + " %"
        
        self.tvFadeCell()
    }
    
    /**
        Fade animation to display cell
    */
    func tvFadeCell() {
        self.tableView?.reloadData()
        let cells = self.tableView?.visibleCells
        var delayCounter = 0.0
        for cell in cells! {
            cell.alpha=0.0
            UIView.animate(withDuration: TimeInterval(delayCounter),animations: {
                cell.alpha = 1.0
                }, completion: nil)
            
            delayCounter += 0.30
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
