// Copyright © Fleuronic LLC. All rights reserved.

public import Schemata

public import struct Dewdrop.Tag
public import struct DewdropService.IdentifiedTag
public import struct PersistDB.Ordering
public import protocol PersistDB.Model
public import protocol Catenoid.Model

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
