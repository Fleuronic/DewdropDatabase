// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Backup
import struct Schemata.Projection
import struct Foundation.Date
import protocol Catena.Representable
import protocol Catenoid.Row
import protocol Catenoid.Model
import protocol DewdropService.BackupFields

public struct BackupRow: BackupFields {
	public let id: Backup.ID
	public let creationDate: Date
}

// MARK: -
extension BackupRow: Row {
	// MARK: Valued
	public typealias Value = Backup

	// MARK: Representable
	public var value: Value {
		.init(creationDate: creationDate)
	}

	// MARK: Row
	public init(from representable: some Representable<Value, IdentifiedValue>) {
		let value = representable.value

		id = representable.id
		creationDate = value.creationDate
	}

	// MARK: ModelProjection
	public static let projection = Projection<Self.Model, Self>(
		Self.init,
		\.id,
		\.value.creationDate
	)
}

// MARK: -
extension BackupRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Backup.Identified> {
		[
			\.value.creationDate == creationDate
		]
	}
}
