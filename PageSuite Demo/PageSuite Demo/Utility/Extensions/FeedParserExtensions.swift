//
//  FeedParserExtensions.swift
//  PageSuite Demo
//
//  Created by Joe Marke on 23/07/2024.
//

import Foundation
import FeedKit

extension FeedParser {
    // Async FeedKit feed parser extension to support async/await.
    public func parseAsync(
        queue: DispatchQueue = DispatchQueue.global()
    ) async throws -> Feed {
        try await withCheckedThrowingContinuation { continuation in
            parseAsync(queue: queue) { result in
                continuation.resume(with: result)
            }
        }
    }
}

