// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import struct Dewdrop.Backup
import struct DewdropService.IdentifiedBackup
import protocol Catenoid.Model

public extension Backup {
	typealias InvalidID = Identified.InvalidID
}

// MARK: -
extension Backup.Identified: Schemata.Model {
	// MARK: Model
	public enum Path: String {
		case id
		case creationDate = "creation_date"
	}

	public static let schema = Schema(
		Self.init,
		\.id * .id,
		\.value.creationDate * .creationDate
	)

	public static let schemaName = "backups"
}

// MARK: -
extension Backup.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.value.creationDate, ascending: false)]
	}
}
