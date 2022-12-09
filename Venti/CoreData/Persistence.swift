//
//  Persistence.swift
//  Venti
//
//  Created by Andriy on 20/08/2022.
//

import CoreData

struct Persistence {
	
	// MARK: - Shared
	static let shared = Persistence()
	
	// MARK: - Properties
	let persistentContainer: NSPersistentContainer
	
	// MARK: - Init
	init(inMemory: Bool = false) {
		persistentContainer = NSPersistentContainer(name: "Venti")
		if inMemory {
			persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
		}
		persistentContainer.loadPersistentStores { description, error in
			if let error = error {
				print("⚠️ Core Data failed to load: \(error.localizedDescription)")
			}
		}
		persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
	}
	
	// MARK: - Helpers
	func saveContext() {
		if persistentContainer.viewContext.hasChanges {
			do {
				try persistentContainer.viewContext.save()
			} catch {
				print("⚠️ Failed to save view context! \(error)")
			}
		}
	}
	
	// MARK: - Preview
	static var preview: Persistence = {
		let result = Persistence(inMemory: true)
		let viewContext = result.persistentContainer.viewContext
		
		for _ in 0..<12 {
			let newItem = PersistentItem(context: viewContext)
			newItem.id = UUID()
			newItem.title = "Some event"
			newItem.createdDate = .now
			newItem.observedDate = Date(timeIntervalSinceNow: .random(in: 10000..<200000))
		}
		
		do {
			try viewContext.save()
		} catch {
			print("⚠️ CoreData Preview failed! \(error)")
		}
		
		return result
	}()
}
