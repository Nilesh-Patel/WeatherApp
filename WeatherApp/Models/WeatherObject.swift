//
//  WeatherObject.swift
//
//  Created by Nilesh Patel on 16/02/17
//  Copyright (c) Copyright © 2017 MIT Agency. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class WeatherObject: Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kWeatherObjectMainKey: String = "main"
	internal let kWeatherObjectNameKey: String = "name"


    // MARK: Properties
	public var internalIdentifier: Int?
	public var main: Main?
	public var name: String?


    // MARK: SwiftyJSON Initalizers
    /**
    Initates the class based on the object
    - parameter object: The object of either Dictionary or Array kind that was passed.
    - returns: An initalized instance of the class.
    */
    convenience public init(object: AnyObject) {
        self.init(json: JSON(object))
    }

    /**
    Initates the class based on the JSON that was passed.
    - parameter json: JSON object from SwiftyJSON.
    - returns: An initalized instance of the class.
    */
    public init(json: JSON) {
		main = Main(json: json[kWeatherObjectMainKey])
		name = json[kWeatherObjectNameKey].string

    }

    // MARK: ObjectMapper Initalizers
    /**
    Map a JSON object to this class using ObjectMapper
    - parameter map: A mapping from ObjectMapper
    */
    required public init?(map: Map){

    }

    /**
    Map a JSON object to this class using ObjectMapper
    - parameter map: A mapping from ObjectMapper
    */
    public func mapping(map: Map) {
		main <- map[kWeatherObjectMainKey]
		name <- map[kWeatherObjectNameKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if main != nil {
			dictionary.updateValue(main!.dictionaryRepresentation() as AnyObject, forKey: kWeatherObjectMainKey)
		}
		if name != nil {
			dictionary.updateValue(name! as AnyObject, forKey: kWeatherObjectNameKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.main = aDecoder.decodeObject(forKey: kWeatherObjectMainKey) as? Main
		self.name = aDecoder.decodeObject(forKey: kWeatherObjectNameKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encode(main, forKey: kWeatherObjectMainKey)
		aCoder.encode(name, forKey: kWeatherObjectNameKey)

    }

}
