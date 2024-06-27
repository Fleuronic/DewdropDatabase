// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Group
import struct Schemata.Projection
import protocol Catenoid.Fields
import protocol DewdropService.GroupFields

public struct GroupTitleFields {
	public let title: String

	// MARK: ModelProjection
	public static let projection = Projection<Model, Self>(
		Self.init,
		\.title
	)
}

// MARK
extension GroupTitleFields: GroupFields {
	// MARK: Fields
	public typealias Model = Group.Identified
}
