// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct Dewdrop.Media
import struct Dewdrop.Cache
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
	public let domain: String
	public let title: String
	public let itemType: Raindrop.ItemType
	public let excerpt: String?
	public let coverURL: URL?
	public let note: String?
	public let cacheStatus: Cache.Status?
	public let cacheSize: Int?
	public let cacheCreationDate: Date?
	public let isFavorite: Bool
	public let isBroken: Bool
	public let creationDate: Date
	public let updateDate: Date
	public let collection: Collection.IDFields
	public let media: [MediaRow]
}

// MARK: -
public extension RaindropRow {
	init(
		raindrop: some Representable<Value, IdentifiedValue>,
		collectionID: Collection.ID,
		media: [MediaRow]
	) {
		let value = raindrop.value
		self.init(
			id: raindrop.id,
			url: value.url,
			domain: value.domain,
			title: value.info.title,
			itemType: value.info.itemType,
			excerpt: value.info.excerpt,
			coverURL: value.info.coverURL,
			note: value.note,
			cacheStatus: value.cache?.status,
			cacheSize: value.cache?.size,
			cacheCreationDate: value.cache?.creationDate,
			isFavorite: value.isFavorite,
			isBroken: value.isBroken,
			creationDate: value.creationDate,
			updateDate: value.updateDate,
			collection: .init(id: collectionID),
			media: media
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
			domain: domain,
			info: .init(
				title: title,
				itemType: itemType,
				excerpt: excerpt,
				coverURL: coverURL
			),
			note: note,
			media: media.map { media in
				.init(
					url: media.url,
					type: media.type
				)
			},
			cache: cacheStatus.map { status in
				.init(
					status: status,
					size: cacheSize,
					creationDate: cacheCreationDate
				)
			},
			reminder: nil, // TODO
			isFavorite: isFavorite,
			isBroken: isBroken,
			creationDate: creationDate,
			updateDate: updateDate
		)
	}

	// MARK: ModelProjection
	public static let projection = Projection<Model, Self>(
		Self.init,
		\.id,
		\.collection.id,
		\.value.url,
		\.value.domain,
		\.value.info.title,
		\.value.info.itemType,
		\.value.info.excerpt,
		\.value.info.coverURL,
		\.value.note,
		\.value.cache?.status,
		\.value.cache?.size,
		\.value.cache?.creationDate,
		\.value.isFavorite,
		\.value.isBroken,
		\.value.creationDate,
		\.value.updateDate,
		\.media.id,
		\.media.value.url,
		\.media.value.type
	)

	// MARK: Fields
	public static func merge(lhs: Self, rhs: Self) -> Self {
		.init(
			id: lhs.id,
			collectionID: lhs.collection.id,
			url: lhs.url,
			domain: lhs.domain,
			title: lhs.title,
			itemType: lhs.itemType,
			excerpt: lhs.excerpt,
			coverURL: lhs.coverURL,
			note: lhs.note,
			cacheStatus: lhs.cacheStatus,
			cacheSize: lhs.cacheSize,
			cacheCreationDate: lhs.cacheCreationDate,
			isFavorite: lhs.isFavorite,
			isBroken: lhs.isBroken,
			creationDate: lhs.creationDate,
			updateDate: lhs.updateDate,
			mediaIDs: lhs.media.map(\.id) + rhs.media.map(\.id),
			mediaURLs: lhs.media.map(\.url) + rhs.media.map(\.url),
			mediaTypes: lhs.media.map(\.type) + rhs.media.map(\.type)
		)
	}
}

extension RaindropRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Raindrop.Identified> {
		[
			\.value.url == url,
			\.value.domain == domain,
			\.value.info.title == title,
			\.value.info.itemType == itemType,
			\.value.info.excerpt == excerpt,
			\.value.info.coverURL == coverURL,
			\.value.note == note,
			\.value.cache?.status == cacheStatus,
			\.value.cache?.size == cacheSize,
			\.value.cache?.creationDate == creationDate,
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
		domain: String,
		title: String,
		itemType: Raindrop.ItemType,
		excerpt: String?,
		coverURL: URL?,
		note: String?,
		cacheStatus: Cache.Status?,
		cacheSize: Int?,
		cacheCreationDate: Date?,
		isFavorite: Bool,
		isBroken: Bool,
		creationDate: Date,
		updateDate: Date,
		mediaIDs: [Media.ID],
		mediaURLs: [URL],
		mediaTypes: [Media.MediaType]
	) {
		let raindropID = id
		self.init(
			id: id,
			url: url,
			domain: domain,
			title: title,
			itemType: itemType,
			excerpt: excerpt,
			coverURL: coverURL,
			note: note,
			cacheStatus: cacheStatus,
			cacheSize: cacheSize,
			cacheCreationDate: cacheCreationDate,
			isFavorite: isFavorite,
			isBroken: isBroken,
			creationDate: creationDate,
			updateDate: updateDate,
			collection: .init(id: collectionID),
			media: mediaIDs.enumerated().map { index, id in
				.init(
					id: id,
					url: mediaURLs[index],
					type: mediaTypes[index],
					raindrop: .init(id: raindropID)
				)
			}
		)
	}
}
