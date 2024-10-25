// Copyright © Fleuronic LLC. All rights reserved.

public import Schemata

public import struct DewdropService.Tagging
public import struct PersistDB.Ordering
public import protocol PersistDB.Model
public import protocol Catenoid.Model

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
