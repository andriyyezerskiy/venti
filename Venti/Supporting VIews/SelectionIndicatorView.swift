//
//  SelectionIndicatorView.swift
//  Venti
//
//  Created by Andriy on 21/12/2022.
//

import SwiftUI

struct SelectionIndicatorView: View {
	
	var isSelected: Bool = false
	
	var body: some View {
		image
			.resizable()
			.foregroundColor(foregroundColor)
			.frame(width: 22, height: 22)
			.animation(.easeInOut, value: isSelected)
	}
	
	var image: Image {
		isSelected ? Image(systemName: "checkmark.circle.fill") : Image(systemName: "circle")
	}
	
	var foregroundColor: Color {
		isSelected ? .blue : .gray
	}
}

struct SelectionIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			SelectionIndicatorView(isSelected: true)
				.previewDisplayName("Selected")
			
			SelectionIndicatorView(isSelected: false)
				.previewDisplayName("Deselected")
		}
		.previewLayout(.sizeThatFits)
    }
}
