// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct Dewdrop.Group
import struct Dewdrop.Filter
import struct Dewdrop.Tag
import struct Dewdrop.Highlight
import struct Dewdrop.User
import struct DewdropService.Tagging
import protocol DewdropService.RaindropFields
import protocol DewdropService.GroupFields
import protocol DewdropService.CollectionFields
import protocol DewdropService.FilterFields
import protocol DewdropService.TagFields
import protocol DewdropService.HighlightFields
import protocol DewdropService.UserFields
import protocol DewdropService.UserAuthenticatedFields
import protocol Catenoid.Fields
import protocol Schemata.AnyModel
import protocol Catenoid.Database

public struct Database<
	RaindropResultFields: RaindropFields & Fields<Raindrop.Identified>,
	RaindropHighlightResultFields: RaindropFields & Fields<Raindrop.Identified>,
	CollectionResultFields: CollectionFields & Fields<Collection.Identified>,
	ChildCollectionResultFields: CollectionFields & Fields<Collection.Identified>,
	SystemCollectionResultFields: CollectionFields & Fields<Collection.Identified>,
	GroupResultFields: GroupFields & Fields<Group.Identified>,
	FilterResultFields: FilterFields & Fields<Filter.Identified>,
	TagResultFields: TagFields & Fields<Tag.Identified>,
	HighlightResultFields: HighlightFields & Fields<Highlight.Identified>,
	UserAuthenticatedResultFields: UserAuthenticatedFields & Fields<User.Identified>,
	UserPublicResultFields: UserFields & Fields<User.Identified>
>: @unchecked Sendable {
	public private(set) var store: Store<ReadWrite>

	// TODO: Default fields
	public init() async {
		store = try! await Self.createStore()
	}
}

// MARK: -
public extension Database {
	typealias RaindropIDProvider = Never
}

// MARK: -
extension Database: Catenoid.Database {
	public static var types: [any AnyModel.Type] {
		[
			Dewdrop.Raindrop.Identified.self,
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
