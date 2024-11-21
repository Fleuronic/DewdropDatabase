// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Collection
import protocol DewdropService.CollectionSpec
import protocol Catena.Scoped
import protocol Catenoid.Database
import protocol Catenoid.ResultProviding

extension Database: CollectionSpec {
	#if swift(<6.0)
	public typealias RootCollectionListFields = CollectionSpecifiedFields
	#endif

	public func fetchCollection(with id: Collection.ID) async -> SingleResult<CollectionSpecifiedFields> {
		fatalError()
	}

	public func listRootCollections() async -> Results<CollectionSpecifiedFields> {
		await fetch(where: .isRoot)
	}

	public func listChildCollections() async -> Results<ChildCollectionSpecifiedFields> {
		await fetch(where: .isChild)
	}

	public func listSystemCollections() async -> Results<SystemCollectionSpecifiedFields> {
		await fetch(where: .isSystem)
	}

	public func listCollaborators(ofCollectionWith id: Collection.ID) async -> NoResults {
		fatalError()
	}

	public func removeCollection(with id: Collection.ID) async -> NoResults {
		await removeCollections(with: [id])
	}

	public func removeCollections(with ids: [Collection.ID]) async -> NoResults {
		await delete(with: ids).map { _ in }
	}

	public func emptyTrash() async -> NoResults {
		fatalError()
	}
}
