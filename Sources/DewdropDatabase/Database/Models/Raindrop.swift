// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.Raindrop
import struct DewdropService.IdentifiedRaindrop
import struct PersistDB.Ordering
import protocol PersistDB.Model
import protocol Catenoid.Model

extension Raindrop.Identified: Schemata.Model, AnyModel {
	// MARK: Model
	public static let schema = Schema(
		Self.init..."raindrops",
		\.id * "id",
		\.title * "title",
		\.url * "url",
		\.collection --> "collection"
	)
}

// MARK: -
extension Raindrop.Identified: PersistDB.Model {
	// MARK: Model
	public static let relationships: Relationships = [
		\.collection.id: \.collection
	]

	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.id, ascending: false)]
	}
}
