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
	
	var body: some View {
		ScrollView(.vertical) {
			eventSection
			
			stylingSection
			
			notificationsSection
		}
		.navigationBarTitleDisplayMode(.inline)
		.toolbarRole(.navigationStack)
		.toolbar(.automatic, for: .navigationBar)
		.toolbar {
			ToolbarItem {
				Button {
					Task {
						await viewModel.save()
						dismiss()
					}
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
			.materialContainer()
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
						ItemTypeSelectionView(selection: $viewModel.type)
					} label: {
						Text(viewModel.type.title)
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
			.materialContainer()
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
			.materialContainer()
		}
		.padding()
	}
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			AddItemView()
				.previewDisplayName("Without NavigationView")
			
			NavigationView {
				AddItemView()
			}.previewDisplayName("With NavigationView")
		}
    }
}
