// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Scoped
import protocol Catenoid.Database
import protocol DewdropService.CollectionSpec

extension Database: CollectionSpec {
	public typealias CollectionList = Self.Result<[CollectionListFields]>
	public typealias CollectionListFields = DewdropDatabase.CollectionListFields
	public typealias ChildCollectionList = Self.Result<[ChildCollectionListFields]>
	public typealias ChildCollectionListFields = DewdropDatabase.ChildCollectionListFields
	public typealias SystemCollectionList = Self.Result<[SystemCollectionListFields]>
	public typealias SystemCollectionListFields = DewdropDatabase.SystemCollectionListFields

	public func listRootCollections() async -> CollectionList {
		await fetch(where: .isRoot)
	}

	public func listChildCollections() async -> ChildCollectionList {
		await fetch(where: .isChild)
	}

	public func listSystemCollections() async -> SystemCollectionList {
		await fetch(where: .isSystem)
	}
}
