//
//  AsyncContentView.swift
//  PageSuite Demo
//
//  Created by Joe Marke on 23/07/2024.
//

import SwiftUI

/// A wrapper for a data dependant view, managing the loading, load failed & successful content states. 
struct AsyncContentView<Loading: View, Failed: View, Content: View>: View {
    let dataFetchState: DataFetchState
    let loadingView: Loading
    let failedView: Failed
    let contentView: Content
    
    init(dataFetchState: DataFetchState,
         @ViewBuilder loadingView: () -> Loading,
         @ViewBuilder failedView: () -> Failed,
         @ViewBuilder contentView: () -> Content) {
        self.dataFetchState = dataFetchState
        self.loadingView = loadingView()
        self.failedView = failedView()
        self.contentView = contentView()
    }
    
    var body: some View {
        switch dataFetchState {
        case .idle:
            // Cannot use EmptyView() here as that results in .onAppear and .task never being called
            Color.clear
        case .loading:
            loadingView
        case .failure:
            failedView
        case .success:
            contentView
        }
    }
}

