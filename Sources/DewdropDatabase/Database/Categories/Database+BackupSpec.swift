// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Backup
import struct Foundation.Data
import struct Identity.Identifier
import protocol DewdropService.BackupSpec
import protocol Catena.Scoped

extension Database: BackupSpec {
	#if swift(<6.0)
	public typealias BackupListFields = BackupSpecifiedFields
	#endif

	public func listBackups() async -> Results<BackupSpecifiedFields> {
		await fetch()
	}

	public func createBackup(using method: BackupCreationMethod) async -> ImpossibleResult<Never> {
		// Cannot create backup using database
	}

	public func downloadBackup(with id: Backup.InvalidID, as format: Backup.FileFormat) async -> ImpossibleResult<Never> {
		// Cannot download backup using database
	}
}

// MARK: -
public extension Database {
	enum BackupCreationMethod {}
}
