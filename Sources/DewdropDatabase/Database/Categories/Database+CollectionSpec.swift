// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Collection
import struct Dewdrop.Raindrop
import protocol DewdropService.CollectionSpec
import protocol Catena.Scoped
import protocol Catenoid.Database

extension Database: CollectionSpec {
	#if swift(<6.0)
	public typealias CollectionFetchFields = RootCollectionSpecifiedFields
	public typealias RootCollectionListFields = RootCollectionSpecifiedFields
	public typealias ChildCollectionListFields = ChildRootCollectionSpecifiedFields
	public typealias SystemCollectionListFields = SystemRootCollectionSpecifiedFields
	#endif

	public func fetchCollection(with id: Collection.ID) async -> SingleResult<RootCollectionSpecifiedFields?> {
		await fetch(where: \.id == id).map(\.first)
	}

	public func listRootCollections() async -> Results<RootCollectionSpecifiedFields> {
		await fetch(where: .isRoot)
	}

	public func listChildCollections() async -> Results<ChildRootCollectionSpecifiedFields> {
		await fetch(where: .isChild)
	}

	public func listSystemCollections() async -> Results<SystemRootCollectionSpecifiedFields> {
		await fetch(where: .isSystem)
	}

	public func removeCollection(with id: Collection.ID) async -> Results<Collection.ID> {
		await removeCollections(with: [id])
	}

	public func removeCollections(with ids: [Collection.ID]) async -> Results<Collection.ID> {
		await delete(with: ids)
	}

	public func emptyTrash() async -> Results<Raindrop.ID> {
		await removeRaindrops(fromCollectionWith: .trash)
	}
}
