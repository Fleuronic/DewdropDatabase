// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.Group
import struct Dewdrop.Collection
import struct DewdropService.IdentifiedGroup
import struct PersistDB.Ordering
import protocol PersistDB.Model
import protocol Catenoid.Model

extension Group.Identified: Schemata.Model {
	// MARK: Model
	public static let schema = Schema(
		Self.init ~ "groups",
		\.id ~ "id",
		\.collections ~ \.group
	)
}

// MARK: -
extension Group.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.id, ascending: false)]
	}
}
