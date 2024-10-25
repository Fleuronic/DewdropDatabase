// Copyright © Fleuronic LLC. All rights reserved.

public import struct Dewdrop.Collection
public import struct Dewdrop.Tag
public import protocol DewdropService.FilterSpec
public import protocol Catena.Scoped
public import protocol Catenoid.Fields

extension Database: FilterSpec {
	public func listFilters(forCollectionWith id: Collection.ID = .all, searchingFor query: String? = nil, sortingTagsBy tagSort: Tag.Sort? = nil) async -> Self.Result<[FilterListFields]> {
		await fetch()
	}
}
