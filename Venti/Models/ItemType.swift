//
//  ItemType.swift
//  Venti
//
//  Created by Andriy on 01/12/2022.
//

import Foundation

enum ItemType: Int, Identifiable, CaseIterable {
	case rome
	case copenhagen
	
	var id: Int { self.rawValue }
	
	var title: String {
		switch self {
		case .rome:
			return "Rome"
		case .copenhagen:
			return "Copenhagen"
		}
	}
	
	var hasImage: Bool {
		switch self {
		case .rome:
			return false
		case .copenhagen:
			return true
		}
	}
}
