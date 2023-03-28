//
//  ContentView.swift
//  SwiftUIAppStoreRatingsDistributionChart
//
//  Created by Salman Biljeek on 3/24/23.
//

import SwiftUI

struct ContentView: View {
    let stars: [Star] = [
        Star(starRating: 5, numberOfRatings: 280_000),
        Star(starRating: 4, numberOfRatings: 76_000),
        Star(starRating: 3, numberOfRatings: 35_000),
        Star(starRating: 2, numberOfRatings: 100),
        Star(starRating: 1, numberOfRatings: 5_000)
    ]
    
    var body: some View {
        VStack(spacing: -2) {
            // Header
            headerView
            
            HStack(spacing: 37) {
                // Avg. rating
                avgRatingView
                
                // Stars distribution
                starsDistributionView
            }
            Spacer()
        }
        .padding(.top, 20)
        .padding([.leading, .trailing], 20)
    }
    
    var headerView: some View {
        HStack {
            Text("Ratings & Reviews")
                .font(.system(size: 22.2, weight: .bold))
            Spacer()
            Button("See All", role: .none) {
                // handle See All Reviews...
            }
            .font(.system(size: 17))
        }
    }
    
    var avgRatingView: some View {
        VStack(spacing: -6) {
            Text(String(format: "%.1f", getAverageRating()))
                .font(.system(size: 60, weight: .bold, design: .rounded))
                .padding(0)
            Text("out of 5")
                .font(.system(size: 15.5, weight: .bold))
                .foregroundColor(.gray)
        }
    }
    
    var starsDistributionView: some View {
        VStack {
            Spacer()
            VStack(spacing: 2.5) {
                ForEach(Array(stars.enumerated()), id: \.offset) { rowIndex, star in
                    RatingsDistributionView(rowIndex: rowIndex, star: star, totalStarRatingsCount: Double(getTotalRatingsCount()))
                }
            }
            HStack {
                Spacer()
                Text("\(getTotalRatingsCountString()) Ratings")
                    .frame(alignment: .trailing)
                    .font(.system(size: 15, design: .rounded))
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 82)
    }
    
    func getTotalRatingsCount() -> Int {
        let totalRatingsCount = stars.map({$0.numberOfRatings}).reduce(0, +)
        return totalRatingsCount
    }
    
    func getAverageRating() -> Double {
        let totalRatingsCount = getTotalRatingsCount()
        var ratingsSum: Double = 0
        for star in stars {
            let starRating = star.starRating
            let starRatingCount = star.numberOfRatings
            let ratingValue = Double((starRatingCount * starRating))
            ratingsSum += ratingValue
        }
        let avgRating = ratingsSum == 0 ? 0 : Double(ratingsSum / Double(totalRatingsCount))
        return avgRating
    }
    
    let decimalNumberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
    
    func getTotalRatingsCountString() -> String {
        let totalRatingsCount = getTotalRatingsCount()
        let totalRatingsCountString = decimalNumberFormatter.string(from: NSNumber(value: totalRatingsCount)) ?? ""
        return totalRatingsCountString
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

