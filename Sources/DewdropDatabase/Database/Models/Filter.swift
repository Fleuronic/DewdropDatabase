// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.Filter
import struct DewdropService.IdentifiedFilter
import struct PersistDB.Ordering
import protocol PersistDB.Model
import protocol Catenoid.Model

extension Filter.Identified: Schemata.Model {
	// MARK: Model
	public enum Path: String {
		case id
		case sortIndex = "sort_index"
		case count
	}

	public static let schema = Schema(
		Self.init,
		\.id * .id,
		\.sortIndex * .sortIndex,
		\.value.count * .count
	)

	public static let schemaName = "filters"
}

// MARK: -
extension Filter.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.sortIndex, ascending: true)]
	}
}
