//
//  Item.swift
//  Venti
//
//  Created by Andriy on 20/08/2022.
//

import Foundation
import SwiftUI

struct Item: Identifiable, Equatable {
	// MARK: - Properties
	let id: UUID
	let type: ItemType
	let title: String
	let observedDate: Date
	let textColor: Color
	let backgroundColor: Color
	let imageData: Data?
	let isNotificationEnabled: Bool
	
	// MARK: - Init
	init(id: UUID, type: ItemType, title: String, observedDate: Date, textColor: Color, backgroundColor: Color, imageData: Data? = nil, isNotificationEnabled: Bool = false) {
		self.id = id
		self.type = type
		self.title = title
		self.observedDate = observedDate
		self.textColor = textColor
		self.backgroundColor = backgroundColor
		self.imageData = imageData
		self.isNotificationEnabled = isNotificationEnabled
	}
	
	init?(persistentItem: PersistentItem) {
		guard let id = persistentItem.id, let type = ItemType(rawValue: persistentItem.type.asInt), let title = persistentItem.title, let observedDate = persistentItem.observedDate, let textColor = Color.from(hex: persistentItem.textColorHex), let backgroundColor = Color.from(hex: persistentItem.backgroundColorHex) else { return nil }
		self.id = id
		self.type = type
		self.title = title
		self.observedDate = observedDate
		self.textColor = textColor
		self.backgroundColor = backgroundColor
		self.imageData = persistentItem.imageData
		self.isNotificationEnabled = persistentItem.isNotificationEnabled
	}
}

extension Item {
	static let previews: [Item] = [
		.init(id: .init(), type: .rome, title: "Birthday", observedDate: Date.init(timeIntervalSinceNow: TimeInterval(20000000)), textColor: .white, backgroundColor: .purple),
		.init(id: .init(), type: .copenhagen, title: "Christmas", observedDate: Date.init(timeIntervalSinceNow: TimeInterval(312831)), textColor: .white, backgroundColor: .green, imageData: UIImage(named: "BackgroundImage")!.pngData()),
		.init(id: .init(), type: .rome, title: "Benek birthday", observedDate: Date.init(timeIntervalSinceNow: TimeInterval(11213)), textColor: .white, backgroundColor: .gray),
		.init(id: .init(), type: .rome, title: "Gusia birthday", observedDate: Date.init(timeIntervalSinceNow: TimeInterval(1233333)), textColor: .white, backgroundColor: .red),
		.init(id: .init(), type: .rome, title: "Vacation", observedDate: Date.init(timeIntervalSinceNow: TimeInterval(123300)), textColor: .white, backgroundColor: .blue),
		.init(id: .init(), type: .rome, title: "Gifts", observedDate: Date.init(timeIntervalSinceNow: TimeInterval(23123200)), textColor: .white, backgroundColor: .yellow),
	]
	
	static func generateRandomPreview(with type: ItemType) -> Item {
		.init(
			id: UUID(),
			type: type,
			title: ItemPreview.titles.randomElement() ?? "",
			observedDate: Date(timeIntervalSinceNow: .random(in: -10000000000...1000000000)),
			textColor: .white,
			backgroundColor: .red
		)
	}
}
