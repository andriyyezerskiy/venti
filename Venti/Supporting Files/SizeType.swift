//
//  SizeType.swift
//  Venti
//
//  Created by Andriy on 08/12/2022.
//

import SwiftUI

enum SizeType {
	case small
	case medium
	case large
	case condensed
	
	var widthToHeightRatio: CGFloat {
		switch self {
		case .small:
			return 1
		case .medium:
			return 0.75
		case .large:
			return 2
		case .condensed:
			return 4
		}
	}
	
	var alignment: Alignment {
		switch self {
		case .small, .medium,  .large:
			return .bottomLeading
		case .condensed:
			return .leading
		}
	}

	func size(with width: CGFloat) -> CGSize {
		CGSize(width: width, height: width * widthToHeightRatio)
	}
}

extension SizeType {
	var previewDisplayName: String {
		switch self {
		case .small:
			return "Small"
		case .medium:
			return "Medium"
		case .large:
			return "Large"
		case .condensed:
			return "Condensed"
		}
	}
}
