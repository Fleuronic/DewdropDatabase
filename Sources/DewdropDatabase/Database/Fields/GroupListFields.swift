// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Group
import struct Schemata.Projection
import protocol Catenoid.Fields
import protocol DewdropService.GroupFields

public struct GroupListFields {
	public let title: String

	// MARK: ModelProjection
	public static let projection = Projection<Model, Self>(
		Self.init,
		\.id
	)
}

extension GroupListFields: Fields {
	public var id: Group.ID { .init(rawValue: title) }
}

// MARK
extension GroupListFields: GroupFields {
	// MARK: Fields
	public typealias Model = Group.Identified
}

// MARK: -
private extension GroupListFields {
	init(
		id: Group.ID
	) {
		title = id.rawValue
	}
}
