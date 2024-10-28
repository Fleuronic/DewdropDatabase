// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct DewdropService.Tagging
import struct PersistDB.Ordering
import protocol PersistDB.Model
import protocol Catenoid.Model

extension Tagging: Schemata.Model {
	// MARK: Model
	public enum Path: String {
		case id
		case tagName
		case raindrop
	}

	public static let schema = Schema(
		Self.init,
		\.id * .id,
		\.tagName * .tagName,
		\.raindrop --> .raindrop
	)

	public static let schemaName = "taggings"
}

// MARK: -
extension Tagging: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.id, ascending: false)]
	}
}
