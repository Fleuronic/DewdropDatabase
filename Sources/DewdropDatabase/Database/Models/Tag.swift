// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.Tag
import struct DewdropService.IdentifiedTag
import struct PersistDB.Ordering
import protocol PersistDB.Model
import protocol Catenoid.Model

extension Tag.Identified: Schemata.Model {
	// MARK: Model
	public enum Path: String {
		case id
		case count
	}

	public static let schema = Schema(
		Self.init,
		\.id * .id,
		\.value.count * .count
	)

	public static let schemaName = "tags"
}

// MARK: -
extension Tag.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.value.count, ascending: false)]
	}
}
