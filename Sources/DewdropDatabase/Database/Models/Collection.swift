// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import struct Dewdrop.Collection
import struct DewdropService.IdentifiedCollection
import protocol Catenoid.Model

extension Collection.Identified: Schemata.Model, AnyModel {
	// MARK: Model
	public static let schema = Schema(
		Self.init..."collections",
		\.id * "id",
		\.title * "title",
		\.count * "count"
	)
}

// MARK: -
extension Collection.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.id, ascending: false)]
	}
}
