//
//  MockView.swift
//  New-Arch-MVI-Presentation
//
//  Created by Tornike Bardadze on 27.10.25.
//

import SwiftUI

public struct FeaturedMovieView: View {
    public let url: URL
    public let title: String
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                default:
                    ProgressView()
                }
            }
            .frame(width: 180, height: 260)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .shadow(color: .black.opacity(0.35), radius: 10, y: 6)
            
            Text(title)
                .font(.subheadline.bold())
                .lineLimit(1)
                .foregroundColor(.primary)
                .frame(width: 180, alignment: .leading)
        }
    }
}


public struct MovieItemView: View {
    public let url: URL
    public let title: String

    @State private var isPressed = false

    public var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                default:
                    Color.gray.opacity(0.2)
                }
            }
            .aspectRatio(2/3, contentMode: .fit)
            .frame(maxWidth: .infinity) // ✅ important
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .shadow(color: .black.opacity(isPressed ? 0.4 : 0.25),
                    radius: isPressed ? 12 : 8,
                    y: 6)
            .scaleEffect(isPressed ? 0.96 : 1.0)
            .animation(.spring(response: 0.25), value: isPressed)
            .contentShape(Rectangle())

            Text(title)
                .font(.callout)
                .lineLimit(1)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 8)
    }
}
