// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Filter
import struct Dewdrop.Collection
import struct Dewdrop.Tag
import protocol DewdropService.FilterSpec
import protocol Catena.Scoped
import protocol Catenoid.Database
import protocol Catenoid.Fields

extension Database: FilterSpec {
	public func listFilters(forCollectionWith id: Collection.ID = .all, searchingFor search: String? = nil, sortingTagsBy tagSort: Tag.Sort? = nil) async -> Self.Result<[FilterListFields]> {
		await fetch()
	}
}
