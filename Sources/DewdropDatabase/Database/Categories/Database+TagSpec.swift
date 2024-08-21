// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Tag
import struct Dewdrop.Collection
import protocol DewdropService.TagSpec
import protocol Catena.Scoped
import protocol Catenoid.Database
import protocol Catenoid.Fields

extension Database: TagSpec {
	public func listTags(inCollectionWith id: Collection.ID? = nil) async -> Self.Result<[TagListFields]> {
		await fetch()
	}
}
