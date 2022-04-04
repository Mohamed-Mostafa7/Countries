//
//  Country.swift
//  Countries
//
//  Created by Mohamed Mostafa on 10/11/2021.
//

import Foundation

struct Country: Decodable {
    let name: Name
    let capital: [String]?
    let maps: Maps
    let latlng: [Double]
    let population: Int
    let timezones: [String]
    let continents: [String]
    let startOfWeek: String
    let flags: Flags
}

struct Name: Decodable {
    var common: String
    var official: String
}

struct Maps: Codable {
    var googleMaps: String
//    var openStreetMaps: String
}

struct Flags: Codable {
    var png: String
//    var svg: String
}

