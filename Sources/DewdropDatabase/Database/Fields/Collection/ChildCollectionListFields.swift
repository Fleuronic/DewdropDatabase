// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.Collection
import struct Catena.IDFields
import protocol Catenoid.Fields
import protocol DewdropService.CollectionFields

public struct ChildCollectionListFields: Fields {
	public let id: Collection.ID
	public let parentID: Collection.ID
	public let title: String
	public let count: Int
	public let isShared: Bool
	public let sortIndex: Int

	// MARK: ModelProjection
	public static let projection = Projection<Model, Self>(
		Self.init,
		\.id,
		\.parentID,
		\.value.title,
		\.value.count,
		\.value.isShared,
		\.value.sortIndex
	)
}

// MARK
extension ChildCollectionListFields: CollectionFields {
	// MARK: Fields
	public typealias Model = Collection.Identified
}

// MARK: -
private extension ChildCollectionListFields {
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
