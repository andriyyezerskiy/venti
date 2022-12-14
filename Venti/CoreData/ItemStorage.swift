//
//  ItemStorage.swift
//  Venti
//
//  Created by Andriy on 20/08/2022.
//

import CoreData
import SwiftUI

final class ItemStorage: ObservableObject {
	
	// MARK: - Shared
	static let shared = ItemStorage()
	
	// MARK: - Properties
	private let persistence: Persistence
	
	@Published var persistentItems: [PersistentItem] = []
	
	// MARK: - Init
	init(isPreview: Bool = false) {
		if isPreview {
			self.persistence = Persistence.preview
		} else {
			self.persistence = Persistence.shared
		}
		
		fetch()
	}
	
	// MARK: - Operations
	func fetch() {
		let request = NSFetchRequest<PersistentItem>(entityName: "PersistentItem")
		
		do {
			persistentItems = try persistence.persistentContainer.viewContext.fetch(request)
		} catch {
			print("⚠️ Failed to fetch records! \(error)")
		}
	}
	
	func add(item: Item) {
		let persistentItem = PersistentItem(context: persistence.persistentContainer.viewContext)
		persistentItem.id = UUID()
		persistentItem.title = item.title
		persistentItem.createdDate = .now
		persistentItem.observedDate = item.observedDate
		persistentItem.textColorHex = item.textColor.toHex()
		persistentItem.backgroundColorHex = item.backgroundColor.toHex()
		
		syncChanges()
	}
	
	func delete(with id: UUID) {
//		persistence.persistentContainer.viewContext.delete(persistentHydrationItem)
		syncChanges()
	}
	
	// MARK: - Helpers
	private func syncChanges() {
		persistence.saveContext()
		fetch()
	}
}
