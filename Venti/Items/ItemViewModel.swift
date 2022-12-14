//
//  ItemViewModel.swift
//  Venti
//
//  Created by Andriy on 20/08/2022.
//

import SwiftUI

class ItemViewModel: ObservableObject {
	
	// MARK: - Properties
	@Published var item: Item
	
	let calendar = Calendar.current
	
	// MARK: - Init
	init(item: Item) {
		self.item = item
	}
	
	// MARK: - Computed Properties
	var dateIsFuture: Bool {
		item.observedDate.timeIntervalSinceNow.sign == .plus
	}
	
	var formattedDate: String {
		DateFormatter.shortDateFormat.string(from: item.observedDate)
	}
	
	var timeFormattedText: String {
		if dateIsFuture {
			let dateComponents = calendar.dateComponents([.day, .hour, .minute], from: .now, to: item.observedDate)
			guard let day = dateComponents.day, let hour = dateComponents.hour, let minute = dateComponents.minute else { return "N/A"}
			return "\(day) days, \(hour) hours, \(minute) minutes left"
		} else {
			let dateComponents = calendar.dateComponents([.day, .hour, .minute], from: item.observedDate, to: .now)
			guard let day = dateComponents.day, let hour = dateComponents.hour, let minute = dateComponents.minute else { return "N/A"}
			return "\(day) days, \(hour) hours, \(minute) minutes since"
		}
	}
	
	var image: UIImage? {
		guard let imageData = item.imageData else { return nil }
		return UIImage(data: imageData)
	}
}

extension ItemViewModel {
	static let romePreview = ItemViewModel(item: .previews[0])
}
