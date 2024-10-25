// Copyright © Fleuronic LLC. All rights reserved.

public import struct Dewdrop.Tag
public import struct Dewdrop.Collection
public import protocol DewdropService.TagSpec
public import protocol Catena.Scoped
public import protocol Catenoid.Fields

extension Database: TagSpec {
	public func listTags(inCollectionWith id: Collection.ID? = nil) async -> Self.Result<[TagListFields]> {
		await fetch()
	}

	public func removeTags(withNames tagNames: [String], fromCollectionWith id: Collection.ID? = nil) async -> Self.Result<Void> {
		let ids = tagNames.map { Tag.ID(rawValue: $0) }
		return await delete(Tag.Identified.self, with: ids).map { _ in }
	}
}
