//
//  WeatherData.swift
//  Amadeus
//
//  Created by Mimosa David on 2/22/23.
//
//Data Models to store JSON data

import Foundation

struct WeatherData: Codable {
    let city: City
    let main: Main
    let weather: [Weather]
}

struct City: Codable {
    let name: String
    let coord: Coord
    let country: String
}
struct Coord: Codable {
    let lat: Double
    let lon: Double
}
struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let main: String
}







