//
//  LocationManager.swift
//  FireworksSolutionsTask
//
//  Created by Saqib Bhatti on 27/12/23.
//

import Foundation
import CoreLocation


struct Location {
    let title: String
    let coordinates: CLLocationCoordinate2D?
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    
    public func findLocations(with query: String, completion: @escaping (([Location]) -> Void)) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(query) { places, error in
            guard let places = places, error == nil else {
                completion([])
                return
            }
            let models: [Location] = places.compactMap ({ place in
                var name = ""
                if let locationName = place.name {
                    name += locationName
                }
                if let adminRegion = place.administrativeArea {
                    name += ", \(adminRegion)"
                }
                if let locality = place.locality {
                    name += ", \(locality)"
                }
                if let country = place.country {
                    name += ", \(country)"
                }
                print("\n\n \(place)\n\n)")
                
                let result = Location(title: name, coordinates: place.location?.coordinate)
                return result
            })
            completion(models)
        }
    }
    
    func resolveLocationName(with location: CLLocation, completion: @escaping ((String?) -> Void)) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, preferredLocale: .current) { placemarks, error in
            guard let place = placemarks?.first, error == nil else {
                completion(nil)
                return
            }
            var name = ""
            
            if let locality = place.locality {
                name += locality
            }
            if let adminRegion = place.administrativeArea {
                name += ", \(adminRegion)"
            }
            completion(name)
        }
    }
}
