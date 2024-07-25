//
//  FeedItem.swift
//  PageSuite Demo
//
//  Created by Joe Marke on 23/07/2024.
//

import Foundation
import FeedKit

// The RSSFeedItem struct does not have a unique ID, so this is manually created.
struct FeedItem: Identifiable {
    let id = UUID()
    let data: RSSFeedItem
}
