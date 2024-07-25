//
//  DateExtensions.swift
//  PageSuite Demo
//
//  Created by Joe Marke on 23/07/2024.
//

import Foundation

extension Date {
    func getTimeAgoString() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: .now)
    }
}
