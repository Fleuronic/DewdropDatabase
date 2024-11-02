// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Collection
import protocol DewdropService.CollectionSpec
import protocol Catena.Scoped
import protocol Catenoid.Database

extension Database: CollectionSpec {
	#if swift(<6.0)
	public typealias RootCollectionListFields = CollectionListFields
	#endif

	public func listRootCollections() async -> Results<CollectionListFields> {
		await fetch(where: .isRoot)
	}

	public func listChildCollections() async -> Results<ChildCollectionListFields> {
		await fetch(where: .isChild)
	}

	public func listSystemCollections() async -> Results<SystemCollectionListFields> {
		await fetch(where: .isSystem)
	}

	public func deleteCollection(with id: Collection.ID) async -> NoResults {
		await deleteCollections(with: [id])
	}

	public func deleteCollections(with ids: [Collection.ID]) async -> NoResults {
		await delete(Collection.Identified.self, with: ids).map { _ in }
	}
}
