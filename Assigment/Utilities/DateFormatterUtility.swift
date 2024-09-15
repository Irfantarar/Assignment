//
//  DateFormatterUtility.swift
//  NB Assigment
//
//  Created by Muhammad Irfan Tarar on 14/09/2024.
//

import Foundation

final class DateFormatterUtility {
    static let shared = DateFormatterUtility()
    
    let apiDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    let displayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    func parseDate(from string: String) -> Date {
        return apiDateFormatter.date(from: string) ?? Date()
    }
}
