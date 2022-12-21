//
//  ItemTypeSelectionView.swift
//  Venti
//
//  Created by Andriy on 01/12/2022.
//

import SwiftUI

struct ItemTypeSelectionView: View {
	
	@Binding var selection: ItemType
		
	let columns: [GridItem] = [GridItem(.adaptive(minimum: 150), spacing: 16)]

	var body: some View {
		ScrollView {
			VStack(spacing: 16) {
				ForEach(ItemType.allCases) { type in
					ItemTypeView(type: type, isSelected: isSelected(type: type))
						.onTapGesture {
							selection = type
						}
				}
			}.padding()
		}
	}
	
	func isSelected(type: ItemType) -> Bool {
		type == selection
	}
}

struct ItemTypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
		ItemTypeSelectionView(selection: .constant(.rome))
    }
}


