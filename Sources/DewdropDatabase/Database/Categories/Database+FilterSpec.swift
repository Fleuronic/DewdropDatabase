// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Filter
import struct Dewdrop.Collection
import struct Dewdrop.Tag
import protocol DewdropService.FilterSpec
import protocol Catena.Scoped
import protocol Catenoid.Database

extension Database: FilterSpec {
	public typealias FilterList = Self.Result<[FilterListFields]>
	public typealias FilterListFields = DewdropDatabase.FilterListFields

	public func listFilters(forCollectionWith id: Collection.ID = .all, searchingFor search: String? = nil, sortingTagsBy tagSort: Tag.Sort? = nil) async -> FilterList {
		await fetch()
	}
}
