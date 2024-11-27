// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct Dewdrop.Highlight
import struct Foundation.URL
import struct Catena.IDFields
import struct Schemata.Projection
import protocol Catena.Representable
import protocol Catenoid.Row
import protocol Catenoid.Model
import protocol DewdropService.RaindropFields

public struct RaindropRow: RaindropFields {
	public let id: Raindrop.ID
	public let url: URL
	public let title: String
	public let itemType: Raindrop.ItemType
	public let isFavorite: Bool
	public let isBroken: Bool
	public let collection: Collection.IDFields
}

// MARK: -
public extension RaindropRow {
	init(
		raindrop: some Representable<Value, IdentifiedValue>,
		collectionID: Collection.ID
	) {
		let value = raindrop.value
		self.init(
			id: raindrop.id,
			collectionID: collectionID,
			url: value.url,
			title: value.title,
			itemType: value.itemType,
			isFavorite: value.isFavorite,
			isBroken: value.isBroken
		)
	}
}

// MARK: -
extension RaindropRow: Row {
	// MARK: Valued
	public typealias Value = Raindrop

	// MARK: Representable
	public var value: Value {
		.init(
			url: url,
			title: title,
			itemType: itemType,
			excerpt: nil, // TODO
			domain: .init(), // TODO
			coverURL: nil, // TODO
			media: [], // TODO
			note: nil, // TODO
			cache: nil, // TODO
			isFavorite: isFavorite,
			isBroken: isBroken,
			creationDate: .init(), // TODO
			updateDate: .init() // TODO
		)
	}

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

extension RaindropRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Raindrop.Identified> {
		[
			\.value.url == url,
			\.value.title == title,
			\.value.itemType == itemType,
			\.value.isFavorite == isFavorite,
			\.value.isBroken == isBroken,
			\.collection == collection.id
		]
	}
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
		self.init(
			id: id,
			url: url,
			title: title,
			itemType: itemType,
			isFavorite: isFavorite,
			isBroken: isBroken,
			collection: .init(id: collectionID)
		)
	}
}
