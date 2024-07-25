//
//  IdentifiableURL.swift
//  PageSuite Demo
//
//  Created by Joe Marke on 25/07/2024.
//

import Foundation

// Multiple feed items can have the same URL, so this struct allows the URLs to be presented without causing layout issues.
struct IdentifiableURL: Identifiable {
    let id = UUID()
    let url: URL
}
