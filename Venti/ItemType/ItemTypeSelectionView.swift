//
//  ItemTypeSelectionView.swift
//  Venti
//
//  Created by Andriy on 01/12/2022.
//

import SwiftUI

struct ItemTypeSelectionView: View {
	let columns: [GridItem] = [GridItem(.adaptive(minimum: 150), spacing: 20)]

	var body: some View {
		LazyVGrid(columns: columns, spacing: 20) {
			ForEach(ItemType.allCases) { type in
				Text(type.title)
			}
		}
		.padding()
	}
}

struct ItemTypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ItemTypeSelectionView()
    }
}
