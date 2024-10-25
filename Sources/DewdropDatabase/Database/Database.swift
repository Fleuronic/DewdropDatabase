// Copyright © Fleuronic LLC. All rights reserved.

public import PersistDB

public import struct Dewdrop.Group
public import struct Dewdrop.Collection
public import struct Dewdrop.Filter
public import struct Dewdrop.Raindrop
public import struct Dewdrop.Tag
public import struct Dewdrop.Highlight
public import struct Dewdrop.User
public import struct DewdropService.Tagging
public import protocol DewdropService.RaindropFields
public import protocol DewdropService.GroupFields
public import protocol DewdropService.CollectionFields
public import protocol DewdropService.FilterFields
public import protocol DewdropService.TagFields
public import protocol DewdropService.HighlightFields
public import protocol Catenoid.Fields
public import protocol Schemata.AnyModel
public import protocol Catenoid.Database

public struct Database<
	RaindropListFields: RaindropFields & Fields<Raindrop.Identified>,
	RaindropCreationFields: RaindropFields & Fields<Raindrop.Identified>,
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
	public static var types: [any AnyModel.Type] {
		[
			Raindrop.Identified.self,
			Collection.Identified.self,
			Group.Identified.self,
			Filter.Identified.self,
			Tag.Identified.self,
			Highlight.Identified.self,
			User.Identified.self,
			Tagging.self
		]
	}

	public func clear() async {
		store.delete(Delete<Raindrop.Identified>(nil))
		store.delete(Delete<Collection.Identified>(nil))
		store.delete(Delete<Group.Identified>(nil))
		store.delete(Delete<Filter.Identified>(nil))
		store.delete(Delete<Tag.Identified>(nil))
		store.delete(Delete<Highlight.Identified>(nil))
		store.delete(Delete<Tagging>(nil))
	}
}
