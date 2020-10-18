//
//  DetailCountryView.swift
//  COVID stats
//
//  Created by Mark Battistella on 11/10/20.
//

import Foundation
import SwiftUI

struct DetailCountryView: View {
	
	@ObservedObject var apiService = APIService<[LiveStats]>()
	
	// pass in country information
	let country: Country
	
	var body: some View {
		VStack {
			switch apiService.state {
				case .isLoading:
					Text("Loading..")
				case .hasData(let stats):
					Text("\(stats.last?.Cases ?? -1)")
				
			}
		}
		.onAppear {
			apiService.getCountryStats(slug: country.slug)
		}
	}
}
