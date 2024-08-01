// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB
import Identity
import Schemata

import struct Dewdrop.Collection
import struct Dewdrop.Group
import struct DewdropService.IdentifiedCollection
import protocol Catenoid.Model

extension Collection.Identified: Schemata.Model {
	// MARK: Model
	public static let schema = Schema(
		Self.init..."collections",
		\Self.id * "id",
		\.parentID * "parent_id",
		\.value.title * "title",
		\.value.count * "count",
		\.value.isShared * "shared",
		\.value.sortIndex * "sort_index",
		\.group -?> "parent_group"
	)
}

// MARK: -
extension Collection.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[
			.init(\.value.sortIndex),
			.init(\.id, ascending: false)
		]
	}
}

// MARK: -
extension [Collection.Identified]: Schemata.Model, @retroactive AnyModel {
	// MARK: Model
	public static let schema = Schema(
		Self.init..."collections",
		\Self.id * "id",
		\.value.title * "title",
		\.value.count * "count",
		\.value.isShared * "shared",
		\.value.sortIndex * "sort_index"
	)
}

// MARK: -
public extension Predicate<Collection.Identified> {
	static var isGrouped: Self {
		!.isSystem
	}
}

// MARK: -
extension Predicate<Collection.Identified> {
	static var isSystem: Self {
		[.all, .unsorted, .trash].contains(\.id)
	}

	static var isRoot: Self {
		\.parentID == nil
	}

	static var isChild: Self {
		\.parentID != nil
	}
}
