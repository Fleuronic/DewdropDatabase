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
	public static var schema: Schema<Self> {
		let id = \Self.id * "id"
		let parentID = \Self.parentID * "parent_id"
		let title = \Self.value.title * "title"
		let count = \Self.value.count * "count"
		let isShared = \Self.value.isShared * "shared"
		let sortIndex = \Self.value.sortIndex * "sort_index"
		let parentGroup = \Self.group -?> "parent_group"

		return .init(
			Self.init..."collections",
			id,
			parentID,
			title,
			count,
			isShared,
			sortIndex,
			parentGroup
		)
	}
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
	public static var schema: Schema<Self> {
		let id = \Self.id * "id"
		let title = \Self.value.title * "title"
		let count: Property<Self, [Int]> = \Self.value.count * "count"
		let isShared = \Self.value.isShared * "shared"
		let sortIndex = \Self.value.sortIndex * "sort_index"

		return .init(
			Self.init..."collections",
			id,
			title,
			count,
			isShared,
			sortIndex
		)
	}
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
