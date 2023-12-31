//
//  Constants.swift
//  FireworksSolutionsTask
//
//  Created by Saqib Bhatti on 28/12/23.
//

import Foundation


struct Constants {
    struct Urls {
        static func urlForCollegesByCountry(country: String) -> URL {
            return URL(string: "http://universities.hipolabs.com/search?country=\(country)")!
        }
    }
}
