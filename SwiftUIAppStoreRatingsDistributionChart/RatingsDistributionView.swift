//
//  RatingsDistributionView.swift
//  SwiftUIAppStoreRatingsDistributionChart
//
//  Created by Salman Biljeek on 3/24/23.
//

import SwiftUI

struct RatingsDistributionView: View {
    
    init(rowIndex: Int, star: Star, totalStarRatingsCount: Double) {
        self.rowIndex = rowIndex
        self.star = star
        self.totalStarRatingsCount = totalStarRatingsCount
    }
    
    let rowIndex: Int
    let star: Star
    let totalStarRatingsCount: Double
    
    var body: some View {
        HStack(spacing: 10) {
            HStack(spacing: 1.9) {
                ForEach(Array((1...5).enumerated()), id: \.offset) { index, element in
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(maxWidth: 6.3, maxHeight: 6.3)
                        .foregroundColor(.gray)
                        .opacity((index >= rowIndex) ? 1 : 0)
                }
            }
            ProgressView(value: Double(star.numberOfRatings), total: totalStarRatingsCount)
                .frame(maxWidth: .infinity)
                .progressViewStyle(.linear)
                .tint(.gray)
        }
    }
}
