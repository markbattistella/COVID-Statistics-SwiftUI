//
//  ContentView.swift
//  COVID stats
//
//  Created by Mark Battistella on 11/10/20.
//

import SwiftUI

struct DashboardView: View {
	
	@ObservedObject var apiService = APIService<Summary>()
	@State var showCountrySelectionScreen = false
	@State var selectedCountry: String? = UserDefaults.standard.string(forKey: UserDefaultKeys.selectedCountry)
	
	var body: some View {
		NavigationView {
			VStack {
				switch apiService.state {
					case .isLoading:
						Text("Loading...")
					case .hasData(let summary):
						ScrollView {
							
							// select country button
							Button(action: {
								showCountrySelectionScreen.toggle()
							}, label: {
								Image(systemName: "mappin.circle.fill")
									.resizable()
									.frame(width: 20, height: 20, alignment: .center)
								Text("Country list")
							})
							.sheet(isPresented: $showCountrySelectionScreen, content: {
								CountrySelectionView(countries: summary.Countries, selectedCountry: $selectedCountry)
							})
							
							// global stats
							Text("Global COVID-19 stats")
								.font(.title)
								.fontWeight(.heavy)
								.padding(.top, 40)
							GlobalStatsView(globalStats: summary.Global)
							
							// selected country stats
							if let slug = selectedCountry {
								VStack {
									Text(slug.replacingOccurrences(of: "-", with: " ").capitalized)
										.font(.title2)
										.fontWeight(.bold)
										.padding(.top, 40)
									DetailCountryView(slug: slug)
								}
							} else {
								VStack {
									Button {
										showCountrySelectionScreen.toggle()
									} label: {
										Text("Please select a country")
									}
								}
								.padding()
							}
						}
						
				}
			}
			.navigationTitle("")
			.navigationBarHidden(true)
		}
		.onAppear {
			apiService.getSummary()
		}
		.onChange(of: selectedCountry, perform: { value in
			UserDefaults.standard.setValue(value, forKey: UserDefaultKeys.selectedCountry)
			self.showCountrySelectionScreen = false
		})
	}
}
