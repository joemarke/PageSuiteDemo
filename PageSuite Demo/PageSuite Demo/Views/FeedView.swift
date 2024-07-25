//
//  FeedView.swift
//  PageSuite Demo
//
//  Created by Joe Marke on 23/07/2024.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            AsyncContentView(dataFetchState: viewModel.fetchFeedState) {
                LoadingView()
            } failedView: {
                FailedView(viewModel: viewModel)
            } contentView: {
                ContentView(viewModel: viewModel)
            }
            .navigationTitle("Feed")
            .task {
                await viewModel.fetchFeed(isInitialFetch: true)
            }
            .refreshable {
                await viewModel.fetchFeed(isInitialFetch: false)
            }
            .overlay(alignment: .bottom) {
                ConnectionErrorOverlay(isShowing: $viewModel.showConnectionErrorOverlay)
            }
        }
    }
}

extension FeedView {
    struct ContentView: View {
        @StateObject var viewModel: ViewModel
        
        var body: some View {
            if viewModel.feedItems.isEmpty {
                NoArticlesView(viewModel: viewModel)
            } else {
                ArticlesView(viewModel: viewModel)
            }
        }
    }
    
    struct LoadingView: View {
        var body: some View {
            ProgressView()
        }
    }
    
    struct FailedView: View {
        @StateObject var viewModel: ViewModel
        
        var body: some View {
            VStack(spacing: 0) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(.red)
                    .padding(.bottom, 8)
                
                Text("Something Went Wrong")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.bottom, 4)
                
                Text("Please check your connection and try again.")
                    .font(.subheadline)
                    .padding(.bottom, 16)
                
                AsyncButton {
                    await viewModel.fetchFeed(isInitialFetch: true)
                } label: {
                    Text("Try Again")
                        .primaryButton()
                }
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
        }
    }
}

extension FeedView.ContentView {
    struct NoArticlesView: View {
        @StateObject var viewModel: FeedView.ViewModel
        
        var body: some View {
            VStack(spacing: 16) {
                Text("No Articles Found")
                    .font(.headline)
                
                AsyncButton {
                    await viewModel.fetchFeed(isInitialFetch: true)
                } label: {
                    Text("Try Again")
                        .primaryButton()
                }
            }
        }
    }
    
    struct ArticlesView: View {
        @StateObject var viewModel: FeedView.ViewModel
        @State private var presentedArticleURL: IdentifiableURL?
        
        var body: some View {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(viewModel.feedItems) { item in
                        FeedItemComponent(item: item)
                            .onTapGesture {
                                if let urlString = item.data.link, let url = URL(string: urlString) {
                                    presentedArticleURL = .init(url: url)
                                }
                            }
                            .sheet(item: $presentedArticleURL) { urlItem in
                                NavigationStack {
                                    WebView(url: urlItem.url)
                                        .toolbar {
                                            ToolbarItem(placement: .topBarLeading) {
                                                Button {
                                                    presentedArticleURL = nil
                                                } label: {
                                                    Text("Done")
                                                        .font(.headline)
                                                }
                                            }
                                        }
                                        .onDisappear {
                                            presentedArticleURL = nil
                                        }
                                }
                            }
                        
                        Divider()
                    }
                }
                .padding(16)
            }
        }
    }
    
    struct FeedItemComponent: View {
        let item: FeedItem
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                if let imageString = item.data.media?.mediaThumbnails?.first?.attributes?.url, let imageURL = URL(string: imageString) {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .clipShape(.rect(cornerRadius: 4))
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                if let title = item.data.title {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .fontDesign(.serif)
                }
                
                if let description = item.data.description {
                    Text(description)
                        .font(.body)
                        .opacity(0.8)
                }
                
                if let pubDate = item.data.pubDate {
                    Text(pubDate.getTimeAgoString())
                        .font(.subheadline)
                        .opacity(0.6)
                        .padding(.top, 8)
                }
            }
        }
    }
}

#Preview {
    FeedView()
}
