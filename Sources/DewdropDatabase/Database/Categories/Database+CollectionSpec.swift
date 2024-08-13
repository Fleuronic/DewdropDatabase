// Copyright © Fleuronic LLC. All rights reserved.

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
}
