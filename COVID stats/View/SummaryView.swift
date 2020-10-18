//
//  ContentView.swift
//  COVID stats
//
//  Created by Mark Battistella on 11/10/20.
//

import SwiftUI

struct SummaryView: View {

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

						Button(action: {
							showCountrySelectionScreen.toggle()
						}, label: {
							Image(systemName: "mappin.circle.fill")
								.resizable()
								.frame(width: 20, height: 20, alignment: .center)
							Text("Countries")
						})
						.sheet(isPresented: $showCountrySelectionScreen, content: {
							CountrySelectionView(countries: summary.Countries, selectedCountry: $selectedCountry)
						})

						Spacer()
						
						GlobalStatsView(globalStats: summary.Global)
						
						Spacer()
						
						selectedCountry.map { countrySlug in
							Text(countrySlug)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
