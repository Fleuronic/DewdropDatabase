// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.Filter
import struct Catena.IDFields
import protocol Catenoid.Fields
import protocol DewdropService.FilterFields

public struct FilterListFields: Fields {
	public let id: Filter.ID
	public let sortIndex: Int
	public let count: Int

	// MARK: ModelProjection
	public static let projection = Projection<Model, Self>(
		Self.init,
		\.id,
		\.sortIndex,
		\.value.count
	)
}

// MARK
extension FilterListFields: FilterFields {
	// MARK: Fields
	public typealias Model = Filter.Identified
}
