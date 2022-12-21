//
//  CopenhagenItemView.swift
//  Venti
//
//  Created by Andriy on 09/12/2022.
//

import SwiftUI

struct CopenhagenItemView: View {
	@ObservedObject var viewModel: ItemViewModel
	@State var sizeType: SizeType
	
    var body: some View {
		VStack {
			if let image = viewModel.image {
				Image(uiImage: image)
					.resizable()
			} else {
				viewModel.item.backgroundColor
			}
		}
		.overlay(alignment: sizeType.alignment, content: {
			VStack {
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
			}
			.background(Material.ultraThin)
			.cornerRadius(16)
			.padding()
		})
		.clipShape(RoundedRectangle(cornerRadius: 16))
		.aspectRatio(sizeType.widthToHeightRatio, contentMode: .fit)
		.contentShape([.dragPreview, .interaction, .contextMenuPreview], RoundedRectangle(cornerRadius: 16))
    }
}

struct CopenhagenItemView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			CopenhagenItemView(viewModel: .copenhagenPreview, sizeType: .small)
				.frame(width: 250)
				.previewDisplayName(ItemViewModel.copenhagenPreview.item.type.title + " " + SizeType.small.previewDisplayName)
			
			CopenhagenItemView(viewModel: .copenhagenPreview, sizeType: .medium)
				.frame(width: 250)
				.previewDisplayName(ItemViewModel.copenhagenPreview.item.type.title + " " + SizeType.medium.previewDisplayName)
			
			CopenhagenItemView(viewModel: .copenhagenPreview, sizeType: .large)
				.previewDisplayName(ItemViewModel.copenhagenPreview.item.type.title + " " + SizeType.large.previewDisplayName)
			
			CopenhagenItemView(viewModel: .copenhagenPreview, sizeType: .condensed)
				.previewDisplayName(ItemViewModel.copenhagenPreview.item.type.title + " " + SizeType.condensed.previewDisplayName)
		}
    }
}
