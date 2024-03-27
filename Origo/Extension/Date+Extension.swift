//
//  Date+Extension.swift
//  Hammer Parking
//
//  Created by yapapp on 02/11/22.
//

import Foundation
import CoreLocation

extension Date{
    func getFormattedDate(format: DateFormat) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format.rawValue
        return dateformat.string(from: self)
    }
    
    func convertUTCToLocalTime(format: DateFormat) -> Date {
        let timeZone = TimeZone.current
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = format.rawValue
        let localDateString = formatter.string(from: self)
        return formatter.date(from: localDateString) ?? self
    }
    
    func convertUTCToTimeInterval() -> TimeInterval {
        let currentUTCDate = Date()
        let timeInterval = timeIntervalSince(currentUTCDate)
        return max(timeInterval, 0) // Ensure the result is not negative
    }
}

extension CLLocation {
    func geocode(completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(self, completionHandler: completion)
    }
}
