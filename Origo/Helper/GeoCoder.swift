//
//  GeoCoder.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 16/02/24.
//

import Foundation
import CoreLocation

struct GeoCoder {
    static func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ name: String?, _ thoroughfare: String?, _ subThorough:  String?, _ locality: String?, _ subLocality:  String?, _ admin: String?, _ subAdmin:  String?, _ country:  String?, _ postalCode: String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.name,
                       placemarks?.first?.thoroughfare,
                       placemarks?.first?.subThoroughfare,
                       placemarks?.first?.locality,
                       placemarks?.first?.subLocality, //district
                       placemarks?.first?.administrativeArea, //state
                       placemarks?.first?.subAdministrativeArea, //city
                       placemarks?.first?.country,
                       placemarks?.first?.postalCode,
                       error)
        }
    }
}
