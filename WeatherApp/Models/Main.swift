//
//  Main.swift
//
//  Created by Nilesh Patel on 16/02/17
//  Copyright (c) Copyright © 2017 MIT Agency. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class Main: Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kMainTempKey: String = "temp"
	internal let kMainTempMinKey: String = "temp_min"
	internal let kMainGrndLevelKey: String = "grnd_level"
	internal let kMainHumidityKey: String = "humidity"
	internal let kMainSeaLevelKey: String = "sea_level"
	internal let kMainTempMaxKey: String = "temp_max"
	internal let kMainPressureKey: String = "pressure"


    // MARK: Properties
	public var temp: Float?
	public var tempMin: Float?
	public var grndLevel: Float?
	public var humidity: Int?
	public var seaLevel: Float?
	public var tempMax: Float?
	public var pressure: Float?


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
		temp = json[kMainTempKey].float
		tempMin = json[kMainTempMinKey].float
		grndLevel = json[kMainGrndLevelKey].float
		humidity = json[kMainHumidityKey].int
		seaLevel = json[kMainSeaLevelKey].float
		tempMax = json[kMainTempMaxKey].float
		pressure = json[kMainPressureKey].float

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
		temp <- map[kMainTempKey]
		tempMin <- map[kMainTempMinKey]
		grndLevel <- map[kMainGrndLevelKey]
		humidity <- map[kMainHumidityKey]
		seaLevel <- map[kMainSeaLevelKey]
		tempMax <- map[kMainTempMaxKey]
		pressure <- map[kMainPressureKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if temp != nil {
			dictionary.updateValue(temp! as AnyObject, forKey: kMainTempKey)
		}
		if tempMin != nil {
			dictionary.updateValue(tempMin! as AnyObject, forKey: kMainTempMinKey)
		}
		if grndLevel != nil {
			dictionary.updateValue(grndLevel! as AnyObject, forKey: kMainGrndLevelKey)
		}
		if humidity != nil {
			dictionary.updateValue(humidity! as AnyObject, forKey: kMainHumidityKey)
		}
		if seaLevel != nil {
			dictionary.updateValue(seaLevel! as AnyObject, forKey: kMainSeaLevelKey)
		}
		if tempMax != nil {
			dictionary.updateValue(tempMax! as AnyObject, forKey: kMainTempMaxKey)
		}
		if pressure != nil {
			dictionary.updateValue(pressure! as AnyObject, forKey: kMainPressureKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.temp = aDecoder.decodeObject(forKey: kMainTempKey) as? Float
		self.tempMin = aDecoder.decodeObject(forKey: kMainTempMinKey) as? Float
		self.grndLevel = aDecoder.decodeObject(forKey: kMainGrndLevelKey) as? Float
		self.humidity = aDecoder.decodeObject(forKey: kMainHumidityKey) as? Int
		self.seaLevel = aDecoder.decodeObject(forKey: kMainSeaLevelKey) as? Float
		self.tempMax = aDecoder.decodeObject(forKey: kMainTempMaxKey) as? Float
		self.pressure = aDecoder.decodeObject(forKey: kMainPressureKey) as? Float

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encode(temp, forKey: kMainTempKey)
		aCoder.encode(tempMin, forKey: kMainTempMinKey)
		aCoder.encode(grndLevel, forKey: kMainGrndLevelKey)
		aCoder.encode(humidity, forKey: kMainHumidityKey)
		aCoder.encode(seaLevel, forKey: kMainSeaLevelKey)
		aCoder.encode(tempMax, forKey: kMainTempMaxKey)
		aCoder.encode(pressure, forKey: kMainPressureKey)

    }

}
