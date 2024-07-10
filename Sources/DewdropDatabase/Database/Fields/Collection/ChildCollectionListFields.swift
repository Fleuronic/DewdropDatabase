// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Collection
import struct Schemata.Projection
import struct Catena.IDFields
import protocol Catenoid.Fields
import protocol DewdropService.CollectionFields

public struct ChildCollectionListFields: Fields {
	public let id: Collection.ID
	public let parentID: Collection.ID
	public let title: String
	public let count: Int

	// MARK: ModelProjection
	public static let projection = Projection<Model, Self>(
		Self.init,
		\.id,
		\.parentID,
		\.value.title,
		\.value.count
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
		count: Int
	) {
		self.id = id
		self.parentID = parentID!
		self.title = title
		self.count = count
	}
}
