//
//  GlobalStatsView.swift
//  COVID stats
//
//  Created by Mark Battistella on 18/10/20.
//

import Foundation
import SwiftUI

struct GlobalStatsView: View {
	
	let globalStats: GlobalStats
	
	var body: some View {
		
		VStack {
			Group {
				VStack {
					Text("\(globalStats.TotalConfirmed - globalStats.TotalRecovered)")
						.font(.largeTitle)
						.foregroundColor(Color.orange)
					Text("Total active")
						.font(.subheadline)
						.foregroundColor(Color.init(.secondaryLabel))
				}
				HStack {
					VStack {
						Text("\(globalStats.TotalConfirmed)")
							.font(.title3)
							.foregroundColor(Color.red)
						Text("Total confirmed")
							.font(.subheadline)
							.foregroundColor(Color.init(.secondaryLabel))
					}
					.padding(20)

					VStack {
						Text("\(globalStats.TotalRecovered)")
							.font(.title3)
							.foregroundColor(Color.green)
						Text("Total recovered")
							.font(.subheadline)
							.foregroundColor(Color.init(.secondaryLabel))
					}
					.padding(20)
				}
			}
			.padding(10)
		}
	}
}
