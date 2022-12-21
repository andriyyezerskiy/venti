//
//  ItemView.swift
//  Venti
//
//  Created by Andriy on 09/12/2022.
//

import SwiftUI

struct ItemView: View {
	
	@ObservedObject var viewModel: ItemViewModel
	
    var body: some View {
		switch viewModel.item.type {
		case .rome:
			RomeItemView(viewModel: viewModel, sizeType: .small)
		case .copenhagen:
			RomeItemView(viewModel: viewModel, sizeType: .small)
		}
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
		ItemView(viewModel: .romePreview)
    }
}
