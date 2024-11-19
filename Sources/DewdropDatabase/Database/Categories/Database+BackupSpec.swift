// Copyright © Fleuronic LLC. All rights reserved.

import enum Dewdrop.FileFormat
import struct Dewdrop.Backup
import struct Foundation.Data
import struct Identity.Identifier
import protocol DewdropService.BackupSpec
import protocol Catena.Scoped
import protocol Catenary.API

extension Database: BackupSpec {
	public func listBackups() async -> Results<BackupSpecifiedFields> {
		await fetch()
	}

	public func createBackup(using creator: BackupCreator) async -> NoResult {
		// Cannot create backup using database
	}

	public func downloadBackup(with id: Backup.InvalidID, as format: FileFormat) async -> NoResult {
		// Cannot download backup using database
	}
}

// MARK: -
public extension Database {
	enum BackupCreator {}
}
