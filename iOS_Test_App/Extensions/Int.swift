//
//  Int.swift
//  iOS_Test_App
//
//  Created by Georgie Muler on 18.07.2022.
//

import Foundation

extension Int {
    func timeshampToDateString() -> String {
        let date = Date(timeIntervalSince1970: Double(self))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+2")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm  MM/dd/yyyy"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
