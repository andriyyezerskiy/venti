//
//  HomeView.swift
//  Venti
//
//  Created by Andriy on 20/08/2022.
//

import SwiftUI

struct HomeView: View {
	
	@EnvironmentObject var viewModel: HomeViewModel
	let columns: [GridItem] = [GridItem(.adaptive(minimum: 150), spacing: 20)]
	
	var body: some View {
		NavigationView {
			ScrollView {
				if viewModel.items.isEmpty {
					Text("No events yet!")
				} else {
					TimelineView(.everyMinute) { _ in
						LazyVGrid(columns: columns, spacing: 20) {
							ReorderableForEach(items: viewModel.items) { item in
								let viewModel = ItemViewModel(item: item)
								RomeItemView(viewModel: viewModel, sizeType: .small)
							} moveAction: { from, to in
								viewModel.items.move(fromOffsets: from, toOffset: to)
							}
						}
						.padding()
						.animation(.easeInOut, value: viewModel.items)
					}
				}
			}
			.navigationTitle("Venti")
			.toolbar {
				ToolbarItem {
					NavigationLink(destination: SettingsView()) {
						Label("Settings", systemImage: "gear.circle.fill")
					}
				}
				
				ToolbarItem {
					NavigationLink(destination: AddItemView()) {
						Label("Add Event", systemImage: "plus.circle.fill")
					}
				}
				
			}
		}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
			.environmentObject(HomeViewModel(isPreview: true))
    }
}
