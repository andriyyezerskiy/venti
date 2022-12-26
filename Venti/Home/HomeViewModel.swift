//
//  HomeViewModel.swift
//  Venti
//
//  Created by Andriy on 20/08/2022.
//

import Combine
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
	
	// MARK: - Properties
	private var cancellables = Set<AnyCancellable>()
	private var itemStorage = ItemStorage.shared
	
	@Published var persistentItems: [PersistentItem] = [] {
		didSet {
			Task { @MainActor in
				items = persistentItems
					.compactMap { Item(persistentItem: $0) }
			}
		}
	}
	
	@Published var items: [Item] = []
	
	// MARK: - Init
	init(isPreview: Bool = false) {
		if isPreview {
			itemStorage = ItemStorage(isPreview: true)
		}
		subscribeToItemStorage()
	}
	
	// MARK: - Subscribers
	func subscribeToItemStorage() {
		itemStorage.$persistentItems
			.receive(on: DispatchQueue.main)
			.sink(receiveValue: { [weak self] persistentItem in
				guard let self = self else { return }
				self.persistentItems = persistentItem
			})
			.store(in: &cancellables)
	}
}
