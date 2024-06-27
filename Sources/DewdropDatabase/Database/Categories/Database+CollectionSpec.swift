// Copyright © Fleuronic LLC. All rights reserved.

import protocol DewdropService.CollectionSpec
import protocol Catena.Scoped
import protocol Catenoid.Database

extension Database: CollectionSpec {
	public typealias CollectionListFields = CollectionTitleFields
	public typealias SystemCollectionListFields = CollectionTitleFields

	public func listRootCollections() async -> Self.Result<[CollectionListFields]> {
		await fetch(CollectionListFields.self)
	}

	public func listChildCollections() async -> Self.Result<[CollectionListFields]> {
		await fetch(CollectionListFields.self)
	}

	public func listSystemCollections() async -> Self.Result<[SystemCollectionListFields]> {
		await fetch(SystemCollectionListFields.self)
	}
}
