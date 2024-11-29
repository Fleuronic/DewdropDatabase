// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Tag
import struct Dewdrop.Collection
import protocol DewdropService.TagSpec
import protocol Catena.Scoped

extension Database: TagSpec {
	#if swift(<6.0)
	public typealias TagListFields = TagRow
	#endif

	public func listTags(inCollectionWith id: Collection.ID? = nil) async -> Results<TagRow> {
		// TODO
		await fetch()
	}

	public func renameTag(withName tagName: String, toName updatedTagName: String, inCollectionWith id: Collection.ID?) async -> EmptyResult {
		.success(()) // TODO
	}

	public func mergeTags(withNames tagNames: [String], intoTagNamed tagName: String, inCollectionWith id: Collection.ID?) async -> EmptyResult {
		.success(()) // TODO
	}

	public func removeTags(withNames tagNames: [String], fromCollectionWith id: Collection.ID? = nil) async -> Results<Tag.ID> {
		// TODO
		let ids = tagNames.map { Tag.ID(rawValue: $0) }
		return await delete(with: ids)
	}
}
