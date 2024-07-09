// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import struct Dewdrop.Collection
import struct Dewdrop.Group
import struct DewdropService.IdentifiedCollection
import protocol Catenoid.Model

extension Collection.Identified: Schemata.Model {
	// MARK: Model
	public static let schema = Schema(
		Self.init ~ "collections",
		\.id ~ "id",
		\.value.title ~ "title",
		\.value.count ~ "count",
		\.group ~ Optional("parent_group"),
		\.parent ~ Optional("parent_collection")
	)
}

// MARK: -
extension Collection.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.id, ascending: false)]
	}
}

// MARK: -
extension [Collection.Identified]: Schemata.Model, AnyModel {
	// MARK: Model
	public static let schema = Schema(
		Self.init ~ "collections",
		\.id ~ "id",
		\.value.title ~ "title",
		\.value.count ~ "count"
	)
}

// MARK: -
extension Predicate<Collection.Identified> {
	static var isSystem: Self {
		[.all, .unsorted, .trash].contains(\.id)
	}
}
