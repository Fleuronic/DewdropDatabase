// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.Filter
import struct DewdropService.IdentifiedFilter
import struct PersistDB.Ordering
import protocol PersistDB.Model
import protocol Catenoid.Model

extension Filter.Identified: Schemata.Model {
	// MARK: Model
	public static let schema = Schema(
		Self.init..."filters",
		\.id * "id",
		\.value.count * "count"
	)
}

// MARK: -
extension Filter.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.id, ascending: true)]
	}
}
