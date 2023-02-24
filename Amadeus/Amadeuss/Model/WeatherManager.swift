//
//  WeatherManager.swift
//  Amadeus
//
//  Created by Mimosa David on 2/22/23.
//Weather Manager to fetch JSON data

import Foundation
class WeatherManager{
    
    static let shared = WeatherManager()
    
    //Initializer access level change now
    private init(){}
    
    /// Description: Read JSON from app bundle
    ///
    /// - Parameter value: JSON file name
    /// - Returns: raw data
    func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }


    ///
    /// <#Description#>: Parse the jsonData using the JSONDecoder
    ///
    /// - Parameter value: raw data
    /// - Returns: array of WeatherModel objects
    func parse(jsonData: Data) -> [WeatherModel]? {
        var weatherModels: [WeatherModel] = []
        var rootArray: [WeatherData]
        do {
            rootArray = try JSONDecoder().decode([WeatherData].self, from: jsonData)
            weatherModels = bindDataToModel(weatherData: rootArray)
        }
        catch {
            print("error: \(error)")
        }
        return weatherModels
    }

    ///
    /// <#Description#>: Bind the data to view model
    /// format the data into view model
    /// - Parameter value: parsed JSON data
    /// - Returns: array of WeatherModel objects
    func bindDataToModel(weatherData: [WeatherData]) -> ([WeatherModel]){
        var rootArray : [WeatherModel] = [WeatherModel]()
        for item in weatherData {
            let city = item.city.name
            let latitude = item.city.coord.lat
            let latRounded = Double(round(100 * latitude) / 100)
            let longitude = item.city.coord.lon
            let lonRounded = Double(round(100 * longitude) / 100)
            let latlon = "Lat:\(latRounded) Lon:\(lonRounded)"
            let country = item.city.country
            let temperature = item.main.temp
            let tempRounded = Double(round(100 * temperature) / 100)
            let temp = "\(tempRounded)ºF"
            let weather = "\(item.weather[0].main)"
            let weatherModel = WeatherModel(city: city, latlon: latlon, temp: temp, country: country, weather: weather)
            rootArray.append(weatherModel)
        }
        return rootArray
    }
    
}






