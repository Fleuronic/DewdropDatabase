// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct DewdropService.IdentifiedRaindrop
import struct PersistDB.Ordering
import protocol PersistDB.Model
import protocol Catenoid.Model

extension Raindrop.Identified: Schemata.Model {
	// MARK: Model
	public static let schema = Schema(
		Self.init..."raindrops",
		\.id * "id",
		\.value.title * "title",
		\.value.url * "url",
		\.collection -?> "collection"
	)
}

// MARK: -
extension Raindrop.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.id, ascending: false)]
	}
}

// MARK: -
extension Predicate<Raindrop.Identified> {
	static func isInCollection(with id: Collection.ID) -> Self {
		switch id {
		case .all: !.isInCollection(with: .trash)
		default: \.collection.id == id
		}
	}
}
