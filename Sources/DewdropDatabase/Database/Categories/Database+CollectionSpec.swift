// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Collection
import protocol DewdropService.CollectionSpec
import protocol Catena.Scoped
import protocol Catenoid.Database

extension Database: CollectionSpec {
	public func listRootCollections() async -> Self.Result<[CollectionListFields]> {
		await fetch(where: .isRoot)
	}

	public func listChildCollections() async -> Self.Result<[ChildCollectionListFields]> {
		await fetch(where: .isChild)
	}

	public func listSystemCollections() async -> Self.Result<[SystemCollectionListFields]> {
		await fetch(where: .isSystem)
	}

	public func deleteCollection(with id: Collection.ID) async -> Self.Result<Void> {
		await deleteCollections(with: [id])
	}

	public func deleteCollections(with ids: [Collection.ID]) async -> Self.Result<Void> {
		await delete(Collection.Identified.self, with: ids).map { _ in }
	}
}
