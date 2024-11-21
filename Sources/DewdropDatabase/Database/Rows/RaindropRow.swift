// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct Dewdrop.Highlight
import struct Foundation.URL
import struct Catena.IDFields
import protocol DewdropService.RaindropFields
import protocol Catenoid.Fields

public struct RaindropRow: RaindropFields {
	public let id: Raindrop.ID
	public let url: URL
	public let title: String
	public let itemType: Raindrop.ItemType
	public let isFavorite: Bool
	public let isBroken: Bool
	public let collection: Collection.IDFields
}

extension RaindropRow: Fields {
	// MARK: ModelProjection
	public static let projection = Projection<Self.Model, Self>(
		Self.init,
		\.id,
		\.collection.id,
		\.value.url,
		\.value.title,
		\.value.itemType,
		\.value.isFavorite,
		\.value.isBroken
	)
}

// MARK: -
private extension RaindropRow {
	#if swift(<6.0)
	@Sendable
	#endif
	init(
		id: Raindrop.ID,
		collectionID: Collection.ID,
		url: URL,
		title: String,
		itemType: Raindrop.ItemType,
		isFavorite: Bool,
		isBroken: Bool
	) {
		self.id = id
		self.title = title
		self.url = url
		self.itemType = itemType
		self.isFavorite = isFavorite
		self.isBroken = isBroken

		collection = .init(id: collectionID)
	}
}
