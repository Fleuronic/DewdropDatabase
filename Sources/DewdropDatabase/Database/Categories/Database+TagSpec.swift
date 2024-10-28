// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Tag
import struct Dewdrop.Collection
import protocol DewdropService.TagSpec
import protocol Catena.Scoped
import protocol Catenoid.Fields

extension Database: TagSpec {
	public func listTags(inCollectionWith id: Collection.ID? = nil) async -> Self.Result<[TagListFields]> {
		await fetch()
	}

	public func removeTags(withNames tagNames: [String], fromCollectionWith id: Collection.ID? = nil) async -> Self.Result<Void> {
		let ids = tagNames.map { Tag.ID(rawValue: $0) }
		return await delete(Tag.Identified.self, with: ids).map { _ in }
	}
}
