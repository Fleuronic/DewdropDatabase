// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.Group
import struct DewdropService.IdentifiedGroup
import struct PersistDB.Ordering
import protocol PersistDB.Model
import protocol Catenoid.Model

extension Group.Identified: Schemata.Model {
	// MARK: Model
	public enum Path: String {
		case id
		case isHidden = "hidden"
		case sortIndex = "sort_index"
	}

	public static let schema = Schema(
		Self.init,
		\.id * .id,
		\.value.isHidden * .isHidden,
		\.value.sortIndex * .sortIndex,
		\.collections <<- \.group
	)

	public static let schemaName = "groups"
}

// MARK: -
extension Group.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[
			.init(\.value.sortIndex),
			.init(\.collections.value.sortIndex)
		]
	}
}
