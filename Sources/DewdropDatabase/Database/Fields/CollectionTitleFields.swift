// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Collection
import struct Schemata.Projection
import protocol Catenoid.Fields
import protocol DewdropService.CollectionFields

public struct CollectionTitleFields: Fields {
	public let id: Collection.ID
	public let title: String
	public let count: Int

	// MARK: ModelProjection
	public static let projection = Projection<Model, Self>(
		Self.init,
		\.id,
		\.title,
		\.count
	)
}

// MARK
extension CollectionTitleFields: CollectionFields {
	// MARK: Fields
	public typealias Model = Collection.Identified
}
