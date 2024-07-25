//
//  API.swift
//  PageSuite Demo
//
//  Created by Joe Marke on 23/07/2024.
//

import Foundation
import FeedKit

class API {
    static func fetchFeedItems() async throws -> [RSSFeedItem]? {
        let feedURL = URL(string: "https://feeds.bbci.co.uk/news/rss.xml")!
        let parser = FeedParser(URL: feedURL)
        return try await parser.parseAsync().rssFeed?.items
    }
}
