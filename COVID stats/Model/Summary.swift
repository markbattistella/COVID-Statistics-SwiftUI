//
//  Summary.swift
//  COVID stats
//
//  Created by Mark Battistella on 18/10/20.
//

import Foundation

struct Summary: Decodable {
	let Global: GlobalStats
	let Countries: [Country]
}
