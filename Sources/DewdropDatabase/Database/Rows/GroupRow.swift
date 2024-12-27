// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Group
import struct Dewdrop.Collection
import struct Catena.IDFields
import struct Schemata.Projection
import struct Foundation.Date
import protocol Catena.Representable
import protocol Catenoid.Row
import protocol Catenoid.Model
import protocol DewdropService.GroupFields

public struct GroupRow: GroupFields {
	public let title: String
	public let isHidden: Bool
	public let sortIndex: Int
}

// MARK: -
public extension GroupRow {
	init(group: some Representable<Value, IdentifiedValue>) {
		let value = group.value
		self.init(
			title: value.title,
			isHidden: value.isHidden,
			sortIndex: value.sortIndex
		)
	}
}

// MARK: -
extension GroupRow: Row {
	// MARK: Valued
	public typealias Value = Group

	// MARK: Representable
	public var value: Group {
		.init(
			title: title,
			sortIndex: sortIndex,
			isHidden: isHidden
		)
	}

	// MARK: ModelProjection
	public var id: Group.ID { .init(rawValue: sortIndex) }

	// MARK: ModelProjection
	public static let projection = Projection<Model, Self>(
		Self.init,
		\.id,
		\.value.title,
		\.value.isHidden
	)
}

extension GroupRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Group.Identified> {
		[
			\.value.title == title,
			\.value.isHidden == isHidden
		]
	}
}

// MARK: -
private extension GroupRow {
	#if swift(<6.0)
	@Sendable
	#endif
	init(
		id: Group.ID,
		title: String,
		isHidden: Bool
	) {
		self.init(
			title: title,
			isHidden: isHidden,
			sortIndex: id.rawValue
		)
	}
}
