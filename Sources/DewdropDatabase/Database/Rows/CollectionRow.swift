// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.Collection
import struct Dewdrop.Group
import protocol Catenoid.Fields
import protocol DewdropService.CollectionFields

public struct CollectionRow: CollectionFields {
	public let id: Collection.ID
	public let parentID: Collection.ID?
	public let title: String
	public let count: Int
	public let isShared: Bool
	public let sortIndex: Int
	public let group: Group.IDFields
}

// MARK
extension CollectionRow: Fields {
	// MARK: ModelProjection
	public static let projection = Projection<Self.Model, Self>(
		Self.init,
		\.id,
		\.parentID,
		\.value.title,
		\.value.count,
		\.value.isShared,
		\.value.sortIndex,
		\.group.id
	)
}

// MARK: -
private extension CollectionRow {
	#if swift(<6.0)
	@Sendable
	#endif
	init(
		id: Collection.ID,
		parentID: Collection.ID?,
		title: String,
		count: Int,
		isShared: Bool,
		sortIndex: Int,
		groupID: Group.ID
	) {
		self.id = id
		self.parentID = parentID
		self.title = title
		self.count = count
		self.isShared = isShared
		self.sortIndex = sortIndex

		group = .init(id: groupID)
	}
}
