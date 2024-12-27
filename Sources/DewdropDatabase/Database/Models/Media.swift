// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import struct Dewdrop.Media
import struct Dewdrop.Raindrop
import struct DewdropService.IdentifiedMedia
import protocol Catenoid.Model

extension Media.Identified: Schemata.Model {
	// MARK: Model
	public enum Path: String {
		case id
		case url
		case type
		case raindrop
	}

	public static var schema: Schema<Self> {
		let id = \Self.id * .id
		let url = \Self.value.url * .url
		let type = \Self.value.type * .type
		let raindrop = \Self.raindrop --> .raindrop

		return .init(
			Self.init,
			id,
			url,
			type,
			raindrop
		)
	}

	public static let schemaName = "media"
}

// MARK: -
extension Media.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.id)]
	}
}

// MARK: -
public extension [Media.Identified] {
	// MARK: Model
	static var schema: Schema<Self> {
		let id = \Self.id * .id
		let url = \Self.value.url * .url
		let type = \Self.value.type * .type

		return .init(
			Self.init,
			id,
			url,
			type
		)
	}
}
