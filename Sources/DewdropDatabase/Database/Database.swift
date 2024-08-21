// Copyright © Fleuronic LLC. All rights reserved.

import Catena
import PersistDB

import struct Dewdrop.Group
import struct Dewdrop.Collection
import struct Dewdrop.Filter
import struct Dewdrop.Raindrop
import struct Dewdrop.Tag
import struct Dewdrop.Highlight
import struct DewdropService.Tagging
import protocol DewdropService.RaindropFields
import protocol DewdropService.GroupFields
import protocol DewdropService.CollectionFields
import protocol DewdropService.FilterFields
import protocol DewdropService.TagFields
import protocol DewdropService.HighlightFields
import protocol Catenoid.Fields
import protocol Schemata.AnyModel
import protocol Catenoid.Database

public struct Database<
	RaindropListFields: RaindropFields & Fields<Raindrop.Identified>,
	CollectionListFields: CollectionFields & Fields<Collection.Identified>,
	ChildCollectionListFields: CollectionFields & Fields<Collection.Identified>,
	SystemCollectionListFields: CollectionFields & Fields<Collection.Identified>,
	GroupListFields: GroupFields & Fields<Group.Identified>,
	FilterListFields: FilterFields & Fields<Filter.Identified>,
	TagListFields: TagFields & Fields<Tag.Identified>,
	HighlightListFields: HighlightFields & Fields<Highlight.Identified>
>: @unchecked Sendable {
	public private(set) var store: Store<ReadWrite>

	public init(
		// TODO: Default fields
	) async {
		store = try! await Self.createStore()
	}
}

// MARK: -
extension Database: Catenoid.Database {
	public static var types: [AnyModel.Type] {
		[
			Raindrop.Identified.self,
			Collection.Identified.self,
			Group.Identified.self,
			Filter.Identified.self,
			Tag.Identified.self,
			Highlight.Identified.self,
			Tagging.self
		]
	}

	public mutating func clear() async throws {
		try Store.destroy()
		store = try await Self.createStore()
	}
}
