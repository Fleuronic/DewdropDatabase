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
		case title
		case isHidden = "hidden"
	}

	public static let schema = Schema(
		Self.init,
		\.id * .id,
		\.value.title * .title,
		\.value.isHidden * .isHidden
	)

	public static let schemaName = "groups"
}

// MARK: -
extension Group.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.id)]
	}
}
