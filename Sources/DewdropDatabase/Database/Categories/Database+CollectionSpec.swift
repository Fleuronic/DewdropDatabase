// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Collection
import protocol DewdropService.CollectionSpec
import protocol Catena.Scoped
import protocol Catenoid.Database

extension Database/*: CollectionSpec*/ {
	#if swift(<6.0)
	public typealias RootCollectionListFields = CollectionResultFields
	#endif

	public func listRootCollections() async -> Results<CollectionResultFields> {
		await fetch(where: .isRoot)
	}

	public func listChildCollections() async -> Results<ChildCollectionResultFields> {
		await fetch(where: .isChild)
	}

	public func listSystemCollections() async -> Results<SystemCollectionResultFields> {
		await fetch(where: .isSystem)
	}

	public func removeCollection(with id: Collection.ID) async -> NoResult {
		await removeCollections(with: [id])
	}

	public func removeCollections(with ids: [Collection.ID]) async -> NoResult {
		await delete(Collection.Identified.self, with: ids).map { _ in }
	}
}
