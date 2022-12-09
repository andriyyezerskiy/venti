//
//  AddItemView.swift
//  Venti
//
//  Created by Andriy on 20/08/2022.
//

import SwiftUI

struct AddItemView: View {
	@Environment(\.dismiss) var dismiss
	
	@StateObject var viewModel: AddItemViewModel = .init()
	static let minimumHeight: CGFloat = 100
	@State var previewHeight: CGFloat = minimumHeight
	
    var body: some View {
		ZStack(alignment: .bottom) {
			ScrollView(.vertical) {
				eventSection
				
				stylingSection
				
				notificationsSection
			}
			
			ZStack(alignment: .top) {
				Color.red
				
				VStack {
					RoundedRectangle(cornerRadius: 6)
						.fill(.ultraThinMaterial)
						.frame(width: 50, height: 6)
						.padding(.top)
				}
			}
			.cornerRadius(24)
			.ignoresSafeArea(.container, edges: .bottom)
			.frame(height: previewHeight, alignment: .bottom)
			.gesture(drag)
		}
		.navigationBarTitleDisplayMode(.inline)
		.toolbarRole(.navigationStack)
		.toolbar(.automatic, for: .navigationBar)
		.toolbar {
			ToolbarItem {
				Button {
					viewModel.save()
					dismiss()
				} label: {
					Text("Save")
				}
			}
		}
    }
	
	var eventSection: some View {
		VStack(alignment: .leading) {
			
			Text("Event")
				.fontWeight(.semibold)
				.padding(.leading)
			
			VStack(spacing: 12){
				TextField("Event title", text: $viewModel.title)
					.textFieldStyle(.plain)
					.padding(.vertical, 6)
					.padding(.horizontal, 12)
					.background(Color.quaternarySystemFill, in: RoundedRectangle(cornerRadius: 6))
				
				HStack {
					Text("Date")
						.fontWeight(.medium)
					
					Spacer()
					
					DatePicker("", selection: $viewModel.date, displayedComponents: .date)
				}
				
				HStack {
					Text("Time")
						.fontWeight(.medium)
					
					Spacer()
					
					DatePicker("", selection: $viewModel.date, displayedComponents: .hourAndMinute)
				}
			}
			.padding()
			.background(Material.ultraThick)
			.cornerRadius(16)
		}
		.padding()
	}
	
	var stylingSection: some View {
		VStack(alignment: .leading) {
			
			Text("Styling")
				.fontWeight(.semibold)
				.padding(.leading)
			
			VStack {
				HStack {
					Text("Type")
						.fontWeight(.medium)
					
					Spacer()
					
					NavigationLink {
						ItemTypeSelectionView()
					} label: {
						Text("Rome")
					}
					.padding(.vertical, 6)
					.padding(.horizontal, 12)
					.background(Color.quaternarySystemFill, in: RoundedRectangle(cornerRadius: 6))

				}
				
				HStack {
					Text("Text color")
						.fontWeight(.medium)
					
					ColorPicker("", selection: $viewModel.textColor)
				}
				
				HStack {
					Text("Background color")
						.fontWeight(.medium)
					
					ColorPicker("", selection: $viewModel.backgroundColor)
				}
			}
			.padding()
			.background(Material.ultraThick)
			.cornerRadius(16)
		}
		.padding()
	}
	
	var notificationsSection: some View {
		VStack(alignment: .leading) {
			
			Text("Notifications")
				.fontWeight(.semibold)
				.padding(.leading)
			
			VStack {
				HStack {
					Text("Enable")
						.fontWeight(.medium)
					
					Spacer()
					
					Toggle("", isOn: $viewModel.isNotificationEnabled)
				}
			}
			.padding()
			.background(Material.ultraThick)
			.cornerRadius(16)
		}
		.padding()
	}
	
	var drag: some Gesture {
		DragGesture()
			.onChanged { value in
				previewHeight = max(100, previewHeight + value.translation.height)
			}
	}
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationStack {
			AddItemView()
		}
    }
}
