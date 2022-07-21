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
        dateFormatter.timeZone = .current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = " dd/MM/yyyy"
        let postDate = dateFormatter.string(from: date)
        return postDate
    } 
}
