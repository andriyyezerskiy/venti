//
//  RomeItemView.swift
//  Venti
//
//  Created by Andriy on 08/12/2022.
//

import SwiftUI

struct RomeItemView: View {
	
	@ObservedObject var viewModel: ItemViewModel
	@State var sizeType: SizeType
	
    var body: some View {
		viewModel.item.backgroundColor
			.overlay(alignment: sizeType.alignment, content: {
				VStack(alignment: .leading, spacing: 8) {
					Text(viewModel.item.title)
						.font(.title2)
						.fontWeight(.bold)
					
					Text(viewModel.timeFormattedText)
						.font(.subheadline)
						.fontWeight(.medium)
				}
				.padding()
				.foregroundColor(viewModel.item.textColor)
			})
			.clipShape(RoundedRectangle(cornerRadius: 16))
			.aspectRatio(sizeType.widthToHeightRatio, contentMode: .fit)
			.contentShape([.dragPreview, .interaction, .contextMenuPreview], RoundedRectangle(cornerRadius: 16))
    }
}

struct RomeItemView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			RomeItemView(viewModel: .romePreview, sizeType: .small)
				.frame(width: 250)
				.previewDisplayName(ItemViewModel.romePreview.item.type.title + " " + SizeType.small.previewDisplayName)
			
			RomeItemView(viewModel: .romePreview, sizeType: .medium)
				.frame(width: 250)
				.previewDisplayName(ItemViewModel.romePreview.item.type.title + " " + SizeType.medium.previewDisplayName)
			
			RomeItemView(viewModel: .romePreview, sizeType: .large)
				.previewDisplayName(ItemViewModel.romePreview.item.type.title + " " + SizeType.large.previewDisplayName)
			
			RomeItemView(viewModel: .romePreview, sizeType: .condensed)
				.previewDisplayName(ItemViewModel.romePreview.item.type.title + " " + SizeType.condensed.previewDisplayName)
		}
		.padding()
    }
}
