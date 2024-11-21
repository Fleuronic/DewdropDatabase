// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.Filter
import protocol Catenoid.Fields
import protocol DewdropService.FilterFields

public struct FilterRow: FilterFields {
	public let id: Filter.ID
	public let sortIndex: Int
	public let count: Int

	#if swift(<6.0)
	@Sendable init(
		id: Filter.ID,
		sortIndex: Int,
		count: Int
	) {
		self.id = id
		self.sortIndex = sortIndex
		self.count = count
	}
	#endif
}

// MARK
extension FilterRow: Fields {
	// MARK: ModelProjection
	public static let projection = Projection<Self.Model, Self>(
		Self.init,
		\.id,
		\.sortIndex,
		\.value.count
	)
}
