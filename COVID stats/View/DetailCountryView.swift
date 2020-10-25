//
//  DetailCountryView.swift
//  COVID stats
//
//  Created by Mark Battistella on 11/10/20.
//

import Foundation
import SwiftUI
import SwiftUICharts

struct DetailCountryView: View {
	
	@ObservedObject var apiService = APIService<[LiveStats]>()
	var slug: String
	
	init(slug: String) {
		self.slug = slug
		apiService.getCountryStats(slug: slug)
	}
	
	var body: some View {
		VStack {
			switch apiService.state {
				case .isLoading:
					Text("Loading..")
				case .hasData(let stats):
					
					HStack(alignment: .lastTextBaseline) {
						VStack {
							Text("\(stats.last?.Confirmed ?? -1)")
								.font(.title3)
								.foregroundColor(Color.red)
							Text("Confirmed")
								.font(.subheadline)
								.foregroundColor(Color.init(.secondaryLabel))
						}
						.padding(20)
						
						VStack {
							Text("\(stats.last?.Active ?? -1)")
								.font(.title3)
								.foregroundColor(Color.orange)
							Text("Active")
								.font(.subheadline)
								.foregroundColor(Color.init(.secondaryLabel))
						}
						
						
						VStack {
							Text("\(stats.last?.Recovered ?? -1)")
								.font(.title3)
								.foregroundColor(Color.green)
							Text("Recovered")
								.font(.subheadline)
								.foregroundColor(Color.init(.secondaryLabel))
						}
						.padding(20)
					}
					
					VStack {
						// graph: confirmed cases
						LineChartView(data: stats.suffix(7).map { Double($0.Confirmed) }, title: "Confirmed", form: ChartForm.extraLarge, dropShadow: false)

						// graph: active cases
						LineChartView(data: stats.suffix(7).map { Double($0.Active) }, title: "Active", form: ChartForm.extraLarge, dropShadow: false)

						// graph: recovered cases
						LineChartView(data: stats.suffix(7).map { Double($0.Recovered) }, title: "Recovered", form: ChartForm.extraLarge, dropShadow: false)
					}
			}
		}
	}
}
