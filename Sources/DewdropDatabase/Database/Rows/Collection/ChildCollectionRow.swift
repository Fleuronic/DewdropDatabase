// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.Collection
import struct Catena.IDFields
import protocol Catenoid.Fields
import protocol DewdropService.CollectionFields

public struct ChildCollectionRow: CollectionFields {
	public let id: Collection.ID
	public let parentID: Collection.ID
	public let title: String
	public let count: Int
	public let isShared: Bool
	public let sortIndex: Int
}

// MARK
extension ChildCollectionRow: Fields {
	// MARK: ModelProjection
	public static let projection = Projection<Self.Model, Self>(
		Self.init,
		\.id,
		\.parentID,
		\.value.title,
		\.value.count,
		\.value.isShared,
		\.value.sortIndex
	)
}

// MARK: -
private extension ChildCollectionRow {
	init(
		id: Collection.ID,
		parentID: Collection.ID?,
		title: String,
		count: Int,
		isShared: Bool,
		sortIndex: Int
	) {
		self.id = id
		self.parentID = parentID!
		self.title = title
		self.count = count
		self.isShared = isShared
		self.sortIndex = sortIndex
	}
}
