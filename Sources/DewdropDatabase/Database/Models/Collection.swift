// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB
import Identity
import Schemata

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct Dewdrop.Group
import struct DewdropService.IdentifiedCollection
import protocol Catenoid.Model

extension Collection.Identified: Schemata.Model {
	// MARK: Model
	public enum Path: String {
		case id
		case parentID = "parent_id"
		case title
		case count
		case isShared = "shared"
		case sortIndex = "sort_index"
		case group = "parent_group"
	}

	public static var schema: Schema<Self> {
		let id = \Self.id * .id
		let parentID = \Self.parentID * .parentID
		let title = \Self.value.title * .title
		let count = \Self.value.count * .count
		let isShared = \Self.value.isShared * .isShared
		let sortIndex = \Self.value.sortIndex * .sortIndex
		let parentGroup = \Self.group -?> .group

		return .init(
			Self.init,
			id,
			parentID,
			title,
			count,
			isShared,
			sortIndex,
			parentGroup
		)
	}

	public static let schemaName = "collections"
}

// MARK: -
extension Collection.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.value.sortIndex)]
	}
}

// MARK: -
extension [Collection.Identified]: Schemata.Model, @retroactive AnyModel {
	// MARK: Model
	public static var schema: Schema<Self> {
		let id = \Self.id * .id
		let parentID = \Self.parentID * .parentID
		let title = \Self.value.title * .title
		let count: Property<Self, [Int]> = \Self.value.count * .count
		let isShared = \Self.value.isShared * .isShared
		let sortIndex = \Self.value.sortIndex * .sortIndex

		return .init(
			Self.init,
			id,
			parentID,
			title,
			count,
			isShared,
			sortIndex
		)
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
