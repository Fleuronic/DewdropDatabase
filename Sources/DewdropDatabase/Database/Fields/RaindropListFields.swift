// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct Foundation.URL
import struct Schemata.Projection
import struct Catena.IDFields
import protocol Catenoid.Fields
import protocol DewdropService.RaindropFields

public struct RaindropListFields: Fields {
	public let id: Raindrop.ID
	public let title: String
	public let url: URL
	public let collection: IDFields<Collection.Identified>?

	// MARK: ModelProjection
	public static let projection = Projection<Model, Self>(
		Self.init,
		\.id,
		\.value.title,
		\.value.url,
		\.collection.id
	)
}

// MARK
extension RaindropListFields: RaindropFields {
	// MARK: Fields
	public typealias Model = Raindrop.Identified
}

// MARK: -
private extension RaindropListFields {
	init(
		id: Raindrop.ID,
		title: String,
		url: URL,
		collectionID: Collection.ID?
	) {
		self.id = id
		self.title = title
		self.url = url

		collection = collectionID.map(IDFields.init)
	}
}
