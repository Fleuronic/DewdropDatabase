// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Filter
import struct Schemata.Projection
import protocol Catena.Representable
import protocol Catenoid.Row
import protocol Catenoid.Model
import protocol DewdropService.FilterFields

public struct FilterRow: FilterFields {
	public let id: Filter.ID
	public let count: Int
	public let sortIndex: Int

	#if swift(<6.0)
	@Sendable
	#endif
	public init(
		id: Filter.ID,
		count: Int,
		sortIndex: Int
	) {
		self.id = id
		self.count = count
		self.sortIndex = sortIndex
	}
}

// MARK: -
extension FilterRow: Row {
	// MARK: Valued
	public typealias Value = Filter

	// MARK: Representable
	public var value: Value {
		.init(count: count)
	}

	// MARK: ModelProjection
	public static let projection = Projection<Self.Model, Self>(
		Self.init,
		\.id,
		\.value.count,
		\.sortIndex
	)
}

extension FilterRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Filter.Identified> {
		[
			\.value.count == count,
			\.sortIndex == sortIndex
		]
	}
}
