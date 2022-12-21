//
//  Container+Style.swift
//  Venti
//
//  Created by Andriy on 12/12/2022.
//

import SwiftUI

struct Container: ViewModifier {
	func body(content: Content) -> some View {
		content
			.padding()
			.background(Material.ultraThick)
			.cornerRadius(16)
	}
}

extension View {
	func materialContainer() -> some View {
		modifier(Container())
	}
}
