// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct Dewdrop.Highlight
import struct Foundation.URL
import struct Foundation.Date
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
	public let excerpt: String?
	public let domain: String
	public let coverURL: URL?
	public let note: String?
	public let isFavorite: Bool
	public let isBroken: Bool
	public let creationDate: Date
	public let updateDate: Date
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
			excerpt: value.excerpt,
			domain: value.domain,
			coverURL: value.coverURL,
			note: value.note,
			isFavorite: value.isFavorite,
			isBroken: value.isBroken,
			creationDate: value.creationDate,
			updateDate: value.updateDate
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
			excerpt: excerpt,
			domain: domain,
			coverURL: coverURL,
			media: [], // TODO
			note: note,
			cache: nil, // TODO
			isFavorite: isFavorite,
			isBroken: isBroken,
			creationDate: creationDate,
			updateDate: updateDate
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
		\.value.excerpt,
		\.value.domain,
		\.value.coverURL,
		\.value.note,
		\.value.isFavorite,
		\.value.isBroken,
		\.value.creationDate,
		\.value.updateDate
	)
}

extension RaindropRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Raindrop.Identified> {
		[
			\.value.url == url,
			\.value.title == title,
			\.value.itemType == itemType,
			\.value.excerpt == excerpt,
			\.value.domain == domain,
			\.value.coverURL == coverURL,
			\.value.note == note,
			\.value.isFavorite == isFavorite,
			\.value.isBroken == isBroken,
			\.value.creationDate == creationDate,
			\.value.updateDate == updateDate,
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
		excerpt: String?,
		domain: String,
		coverURL: URL?,
		note: String?,
		isFavorite: Bool,
		isBroken: Bool,
		creationDate: Date,
		updateDate: Date
	) {
		self.init(
			id: id,
			url: url,
			title: title,
			itemType: itemType,
			excerpt: excerpt,
			domain: domain,
			coverURL: coverURL,
			note: note,
			isFavorite: isFavorite,
			isBroken: isBroken,
			creationDate: creationDate,
			updateDate: updateDate,
			collection: .init(id: collectionID)
		)
	}
}
