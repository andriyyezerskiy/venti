//
//  Color.swift
//  Venti
//
//  Created by Andriy on 27/08/2022.
//

import SwiftUI

extension Color {
	static let tertiarySystemFill: Color = Color(uiColor: .tertiarySystemFill)
	static let quaternarySystemFill: Color = Color(uiColor: .quaternarySystemFill)
	
	static let systemGreen: Color = Color(uiColor: .systemGreen)
	static let systemOrange: Color = Color(uiColor: .systemOrange)
	static let systemRed: Color = Color(uiColor: .systemRed)
}

extension Color {
	static func from(hex: String?) -> Color? {
		guard let hex = hex else { return nil }
		var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
		hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
		
		var rgb: UInt64 = 0
		
		var r: CGFloat = 0.0
		var g: CGFloat = 0.0
		var b: CGFloat = 0.0
		var a: CGFloat = 1.0
		
		let length = hexSanitized.count
		
		guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
		
		if length == 6 {
			r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
			g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
			b = CGFloat(rgb & 0x0000FF) / 255.0
			
		} else if length == 8 {
			r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
			g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
			b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
			a = CGFloat(rgb & 0x000000FF) / 255.0
			
		} else {
			return nil
		}
		
		return Color(red: r, green: g, blue: b, opacity: a)
	}
	
	func toHex() -> String? {
		let uic = UIColor(self)
		guard let components = uic.cgColor.components, components.count >= 3 else {
			return nil
		}
		let r = Float(components[0])
		let g = Float(components[1])
		let b = Float(components[2])
		var a = Float(1.0)
		
		if components.count >= 4 {
			a = Float(components[3])
		}
		
		if a != Float(1.0) {
			return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
		} else {
			return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
		}
	}
}
