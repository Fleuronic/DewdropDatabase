// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.Tag
import struct Catena.IDFields
import protocol Catenoid.Fields
import protocol DewdropService.TagFields

public struct TagRow: TagFields {
	public let name: String
	public let count: Int
}

// MARK
extension TagRow: Fields {
	// MARK: ModelProjection
	public var id: Tag.ID { .init(rawValue: name) }

	// MARK: ModelProjection
	public static let projection = Projection<Self.Model, Self>(
		Self.init,
		\.id,
		\.value.count
	)
}

// MARK: -
private extension TagRow {
	#if swift(<6.0)
	@Sendable
	#endif
	init(
		id: Tag.ID,
		count: Int
	) {
		self.count = count

		name = id.rawValue
	}
}
