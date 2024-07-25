//
//  ConnectionErrorOverlay.swift
//  PageSuite Demo
//
//  Created by Joe Marke on 25/07/2024.
//

import SwiftUI

struct ConnectionErrorOverlay: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        if isShowing {
            HStack {
                Image(systemName: "wifi.slash")
                
                Text("No Internet Connection")
            }
            .foregroundStyle(.white)
            .font(.headline)
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .clipShape(.rect(cornerRadius: 8))
            .padding(12)
            .onTapGesture {
                withAnimation {
                    isShowing = false
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isShowing = false
                    }
                }
            }
        }
    }
}

#Preview {
    ConnectionErrorOverlay(isShowing: .constant(true))
}
