//
//  ItemTypeView.swift
//  Venti
//
//  Created by Andriy on 21/12/2022.
//

import SwiftUI

struct ItemTypeView: View {
	
	let columns: [GridItem] = [GridItem(.adaptive(minimum: 150), spacing: 16)]
	
	let type: ItemType
	var isSelected: Bool = false
	
	var body: some View {
		VStack {
			HStack {
				Text(type.title)
					.font(.subheadline)
					.fontWeight(.semibold)
				
				Spacer()
				
				SelectionIndicatorView(isSelected: isSelected)
			}
			
			LazyVGrid(columns: columns, spacing: 16) {
				ForEach(0..<4) {_ in
					ItemView(viewModel: type.selectionPreview)
				}
			}
		}
		.materialContainer()
	}
}

struct ItemTypeView_Previews: PreviewProvider {
    static var previews: some View {
		ItemTypeView(type: .rome)
			.padding()
    }
}
