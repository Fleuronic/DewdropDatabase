// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.Collection
import protocol Catenoid.Fields
import protocol DewdropService.CollectionFields

public struct SystemCollectionRow: CollectionFields {
	public let id: Collection.ID
	public let title: String
	public let count: Int
	public let sortIndex: Int

	#if swift(<6.0)
	@Sendable init(
		id: Collection.ID,
		title: String,
		count: Int,
		sortIndex: Int
	) {
		self.id = id
		self.title = title
		self.count = count
		self.sortIndex = sortIndex
	}
	#endif
}

// MARK
extension SystemCollectionRow: Fields {
	// MARK: ModelProjection
	public static let projection = Projection<Self.Model, Self>(
		Self.init,
		\.id,
		\.value.title,
		\.value.count,
		\.value.sortIndex
	)
}
