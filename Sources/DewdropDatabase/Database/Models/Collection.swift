// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB
import Schemata

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct DewdropService.IdentifiedCollection
import protocol Catenoid.Model

extension Collection.Identified: Schemata.Model {
	// MARK: Model
	public enum Path: String {
		case id
		case parentID = "parent_id"
		case title
		case count
		case coverURL = "cover_url"
		case colorString = "color_string"
		case view
		case accessLevel = "access_level"
		case isDraggable = "draggable"
		case sortIndex = "sort_index"
		case isPublic = "public"
		case isShared = "shared"
		case isExpanded = "expanded"
		case creationDate = "creation_date"
		case updateDate = "update_date"
		case group = "parent_group"
	}

	public static var schema: Schema<Self> {
		let id = \Self.id * .id
		let parentID = \Self.parentID * .parentID
		let title = \Self.value.title * .title
		let count = \Self.value.count * .count
		let coverURL = \Self.value.coverURL * .coverURL
		let colorString = \Self.value.colorString * .colorString
		let view = \Self.value.view * .view
		let accessLevel = \Self.value.access.level * .accessLevel
		let isDraggable = \Self.value.access.isDraggable * .isDraggable
		let sortIndex = \Self.value.sortIndex * .sortIndex
		let isPublic = \Self.value.isPublic * .isPublic
		let isShared = \Self.value.isShared * .isShared
		let isExpanded = \Self.value.isExpanded * .isExpanded
		let creationDate = \Self.value.creationDate * .creationDate
		let updateDate = \Self.value.updateDate * .updateDate
		let group = \Self.group -?> .group

		return .init(
			Self.init,
			id,
			parentID,
			title,
			count,
			coverURL,
			colorString,
			view,
			accessLevel,
			isDraggable,
			sortIndex,
			isPublic,
			isShared,
			isExpanded,
			creationDate,
			updateDate,
			group
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
