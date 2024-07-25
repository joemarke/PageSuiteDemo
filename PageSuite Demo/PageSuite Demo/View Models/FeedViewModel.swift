//
//  FeedViewModel.swift
//  PageSuite Demo
//
//  Created by Joe Marke on 23/07/2024.
//

import SwiftUI
import FeedKit

extension FeedView {
    @MainActor class ViewModel: ObservableObject {
        @Published var fetchFeedState: DataFetchState = .idle
        @Published var refreshFeedState: DataFetchState = .idle
        @Published var showConnectionErrorOverlay = false
        @Published var feedItems: [FeedItem] = []
        
        func fetchFeed(isInitialFetch: Bool) async {
            setFeedState(isInitialFetch: isInitialFetch, value: .loading)
            do {
                let rssFeedItems = try await API.fetchFeedItems()
                feedItems = rssFeedItems?.map { FeedItem(data: $0) } ?? []
                // If the item does not have a date, use the distant past date to keep it at the end of the list.
                feedItems.sort(by: {($0.data.pubDate ?? .distantPast) > ($1.data.pubDate ?? .distantPast)})
                setFeedState(isInitialFetch: isInitialFetch, value: .success)
            } catch {
                // Show the connection error overlay when the refresh fails.
                if !isInitialFetch {
                    withAnimation {
                        showConnectionErrorOverlay = true
                    }
                }
                setFeedState(isInitialFetch: isInitialFetch, value: .failure)
            }
        }
        
        private func setFeedState(isInitialFetch: Bool, value: DataFetchState) {
            isInitialFetch ? (fetchFeedState = value) : (refreshFeedState = value)
        }
    }
}
