// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Collection
import struct Dewdrop.Tag
import protocol DewdropService.FilterSpec
import protocol Catena.Scoped

extension Database: FilterSpec {
	public func listFilters(forCollectionWith id: Collection.ID = .all, searchingFor query: String? = nil, sortingTagsBy tagSort: Tag.Sort? = nil) async -> Results<FilterSpecifiedFields> {
		await fetch()
	}
}
