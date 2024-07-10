// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Collection
import struct Dewdrop.Group
import struct Schemata.Projection
import struct Catena.IDFields
import protocol Catenoid.Fields
import protocol DewdropService.CollectionFields

public struct CollectionListFields: Fields {
	public let id: Collection.ID
	public let parentID: Collection.ID?
	public let title: String
	public let count: Int
	public let group: IDFields<Group.Identified>?

	// MARK: ModelProjection
	public static let projection = Projection<Model, Self>(
		Self.init,
		\.id,
		\.parentID,
		\.value.title,
		\.value.count,
		\.group.id
	)
}

// MARK
extension CollectionListFields: CollectionFields {
	// MARK: Fields
	public typealias Model = Collection.Identified
}

// MARK: -
private extension CollectionListFields {
	init(
		id: Collection.ID,
		parentID: Collection.ID?,
		title: String,
		count: Int,
		groupID: Group.ID?
	) {
		self.id = id
		self.parentID = parentID
		self.title = title
		self.count = count

		group = groupID.map(IDFields.init)
	}
}
