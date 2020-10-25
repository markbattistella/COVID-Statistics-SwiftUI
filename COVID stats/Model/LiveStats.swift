//
//  LiveStats.swift
//  COVID stats
//
//  Created by Mark Battistella on 11/10/20.
//

import Foundation

struct LiveStats: Decodable {
	let Confirmed: Int
	let Active: Int
	let Recovered: Int
}
