// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct Foundation.URL
import struct Schemata.Projection
import struct Catena.IDFields
import protocol Catenoid.Fields
import protocol DewdropService.RaindropFields

public struct RaindropTitleFields: Fields {
	public let id: Raindrop.ID
	public let title: String
	public let url: URL
	public let collection: IDFields<Collection.Identified>

	// MARK: ModelProjection
	public static let projection = Projection<Model, Self>(
		Self.init,
		\.id,
		\.title,
		\.url,
		\.collection.id
	)
}

// MARK
extension RaindropTitleFields: RaindropFields {
	// MARK: Fields
	public typealias Model = Raindrop.Identified
}

// MARK: -
private extension RaindropTitleFields {
	init(
		id: Raindrop.ID,
		title: String,
		url: URL,
		collectionID: Collection.ID
	) {
		self.id = id
		self.title = title
		self.url = url

		collection = .init(id: collectionID)
	}
}