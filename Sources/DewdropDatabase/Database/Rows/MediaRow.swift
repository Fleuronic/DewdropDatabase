// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Media
import struct Dewdrop.Raindrop
import struct Schemata.Projection
import struct Foundation.Date
import struct Foundation.URL
import protocol Catena.Representable
import protocol Catenoid.Row
import protocol Catenoid.Model
import protocol DewdropService.MediaFields

public struct MediaRow: MediaFields {
	public let id: Media.ID
	public let url: URL
	public let type: Media.MediaType
	public let raindrop: Raindrop.IDFields
}

// MARK: -
public extension MediaRow {
	init(
		media: Value,
		raindropID: Raindrop.ID
	) {
		let value = media
		self.init(
			id: .random,
			raindropID: raindropID,
			url: value.url,
			type: value.type
		)
	}
}

// MARK: -
extension MediaRow: Row {
	// MARK: Valued
	public typealias Value = Media

	// MARK: Representable
	public var value: Value {
		.init(
			url: url,
			type: type
		)
	}

	// MARK: ModelProjection
	public static let projection = Projection<Self.Model, Self>(
		Self.init,
		\.id,
		\.raindrop.id,
		\.value.url,
		\.value.type
	)
}

// MARK: -
extension MediaRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Media.Identified> {
		[
			\.value.url == url,
			\.value.type == type,
			\.raindrop == raindrop.id
		]
	}
}

// MARK: -
private extension MediaRow {
	#if swift(<6.0)
	@Sendable
	#endif
	init(
		id: Media.ID,
		raindropID: Raindrop.ID,
		url: URL,
		type: Media.MediaType
	) {
		self.init(
			id: id,
			url: url,
			type: type,
			raindrop: .init(id: raindropID)
		)
	}
}
