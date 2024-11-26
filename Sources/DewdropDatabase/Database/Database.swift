// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct Dewdrop.Group
import struct Dewdrop.Filter
import struct Dewdrop.Tag
import struct Dewdrop.Highlight
import struct Dewdrop.User
import struct Dewdrop.Collaborator
import struct Dewdrop.Backup
import struct DewdropService.Tagging
import protocol DewdropService.RaindropFields
import protocol DewdropService.GroupFields
import protocol DewdropService.CollectionFields
import protocol DewdropService.FilterFields
import protocol DewdropService.TagFields
import protocol DewdropService.HighlightFields
 import protocol DewdropService.UserFields
import protocol DewdropService.UserAuthenticatedFields
import protocol DewdropService.BackupFields
import protocol Catenoid.Fields
import protocol Schemata.AnyModel
import protocol Catenoid.Database

public struct Database<
	RaindropSpecifiedFields: RaindropFields & Fields<Raindrop.Identified>,
	RootCollectionSpecifiedFields: CollectionFields & Fields<Collection.Identified>,
	ChildRootCollectionSpecifiedFields: CollectionFields & Fields<Collection.Identified>,
	SystemRootCollectionSpecifiedFields: CollectionFields & Fields<Collection.Identified>,
	GroupSpecifiedFields: GroupFields & Fields<Group.Identified>,
	FilterSpecifiedFields: FilterFields & Fields<Filter.Identified>,
	HighlightSpecifiedFields: HighlightFields & Fields<Highlight.Identified>,
	HighlightInRaindropSpecifiedFields: HighlightFields & Fields<Highlight.Identified>,
	UserAuthenticatedSpecifiedFields: UserAuthenticatedFields & Fields<User.Identified>,
	UserPublicSpecifiedFields: UserFields & Fields<User.Identified>,
	BackupSpecifiedFields: BackupFields & Fields<Backup.Identified>
>: @unchecked Sendable {
	public let store: Store<ReadWrite>
}

// MARK: -
public extension Database<
	RaindropRow,
	RootCollectionRow,
	ChildCollectionRow,
	SystemCollectionRow,
	GroupRow,
	FilterRow,
	HighlightRow,
	HighlightRow,
	UserRow,
	UserRow,
	BackupRow
>{
	init() async {
		store = try! await Self.createStore()
	}

	init(store: PersistDB.Store<ReadWrite>) {
		self.store = store
	}
}

public extension Database {
	func specifyingRaindropFields<Fields>(_: Fields.Type) -> Database<
		Fields,
		RootCollectionSpecifiedFields,
		ChildRootCollectionSpecifiedFields,
		SystemRootCollectionSpecifiedFields,
		GroupSpecifiedFields,
		FilterSpecifiedFields,
		HighlightSpecifiedFields,
		HighlightInRaindropSpecifiedFields,
		UserAuthenticatedSpecifiedFields,
		UserPublicSpecifiedFields,
		BackupSpecifiedFields
	> { .init(store: store) }

	func specifyingCollectionFields<Fields>(_: Fields.Type) -> Database<
		RaindropSpecifiedFields,
		Fields,
		ChildRootCollectionSpecifiedFields,
		SystemRootCollectionSpecifiedFields,
		GroupSpecifiedFields,
		FilterSpecifiedFields,
		HighlightSpecifiedFields,
		HighlightInRaindropSpecifiedFields,
		UserAuthenticatedSpecifiedFields,
		UserPublicSpecifiedFields,
		BackupSpecifiedFields
	> { .init(store: store) }

	func specifyingChildCollectionFields<Fields>(_: Fields.Type) -> Database<
		RaindropSpecifiedFields,
		RootCollectionSpecifiedFields,
		Fields,
		SystemRootCollectionSpecifiedFields,
		GroupSpecifiedFields,
		FilterSpecifiedFields,
		HighlightSpecifiedFields,
		HighlightInRaindropSpecifiedFields,
		UserAuthenticatedSpecifiedFields,
		UserPublicSpecifiedFields,
		BackupSpecifiedFields
	> { .init(store: store) }

	func specifyingSystemCollectionFields<Fields>(_: Fields.Type) -> Database<
		RaindropSpecifiedFields,
		RootCollectionSpecifiedFields,
		ChildRootCollectionSpecifiedFields,
		Fields,
		GroupSpecifiedFields,
		FilterSpecifiedFields,
		HighlightSpecifiedFields,
		HighlightInRaindropSpecifiedFields,
		UserAuthenticatedSpecifiedFields,
		UserPublicSpecifiedFields,
		BackupSpecifiedFields
	> { .init(store: store) }

	func specifyingGroupFields<Fields>(_: Fields.Type) -> Database<
		RaindropSpecifiedFields,
		RootCollectionSpecifiedFields,
		ChildRootCollectionSpecifiedFields,
		SystemRootCollectionSpecifiedFields,
		Fields,
		FilterSpecifiedFields,
		HighlightSpecifiedFields,
		HighlightInRaindropSpecifiedFields,
		UserAuthenticatedSpecifiedFields,
		UserPublicSpecifiedFields,
		BackupSpecifiedFields
	> { .init(store: store) }

	func specifyingFilterFields<Fields>(_: Fields.Type) -> Database<
		RaindropSpecifiedFields,
		RootCollectionSpecifiedFields,
		ChildRootCollectionSpecifiedFields,
		SystemRootCollectionSpecifiedFields,
		GroupSpecifiedFields,
		Fields,
		HighlightSpecifiedFields,
		HighlightInRaindropSpecifiedFields,
		UserAuthenticatedSpecifiedFields,
		UserPublicSpecifiedFields,
		BackupSpecifiedFields
	> { .init(store: store) }

	func specifyingHighlightFields<Fields>(_: Fields.Type) -> Database<
		RaindropSpecifiedFields,
		RootCollectionSpecifiedFields,
		ChildRootCollectionSpecifiedFields,
		SystemRootCollectionSpecifiedFields,
		GroupSpecifiedFields,
		FilterSpecifiedFields,
		Fields,
		HighlightInRaindropSpecifiedFields,
		UserAuthenticatedSpecifiedFields,
		UserPublicSpecifiedFields,
		BackupSpecifiedFields
	> { .init(store: store) }


	func specifyingHighlightInRaindropFields<Fields>(_: Fields.Type) -> Database<
		RaindropSpecifiedFields,
		RootCollectionSpecifiedFields,
		ChildRootCollectionSpecifiedFields,
		SystemRootCollectionSpecifiedFields,
		GroupSpecifiedFields,
		FilterSpecifiedFields,
		HighlightSpecifiedFields,
		Fields,
		UserAuthenticatedSpecifiedFields,
		UserPublicSpecifiedFields,
		BackupSpecifiedFields
	> { .init(store: store) }

	func specifyingUserAuthenticatedFields<Fields>(_: Fields.Type) -> Database<
		RaindropSpecifiedFields,
		RootCollectionSpecifiedFields,
		ChildRootCollectionSpecifiedFields,
		SystemRootCollectionSpecifiedFields,
		GroupSpecifiedFields,
		FilterSpecifiedFields,
		HighlightSpecifiedFields,
		HighlightInRaindropSpecifiedFields,
		Fields,
		UserPublicSpecifiedFields,
		BackupSpecifiedFields
	> { .init(store: store) }

	func specifyingUserPublicFields<Fields>(_: Fields.Type) -> Database<
		RaindropSpecifiedFields,
		RootCollectionSpecifiedFields,
		ChildRootCollectionSpecifiedFields,
		SystemRootCollectionSpecifiedFields,
		GroupSpecifiedFields,
		FilterSpecifiedFields,
		HighlightSpecifiedFields,
		HighlightInRaindropSpecifiedFields,
		UserAuthenticatedSpecifiedFields,
		Fields,
		BackupSpecifiedFields
	> { .init(store: store) }

	func specifyingBackupFields<Fields>(_: Fields.Type) -> Database<
		RaindropSpecifiedFields,
		RootCollectionSpecifiedFields,
		ChildRootCollectionSpecifiedFields,
		SystemRootCollectionSpecifiedFields,
		GroupSpecifiedFields,
		FilterSpecifiedFields,
		HighlightSpecifiedFields,
		HighlightInRaindropSpecifiedFields,
		UserAuthenticatedSpecifiedFields,
		UserPublicSpecifiedFields,
		Fields
	> { .init(store: store) }
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
			Collaborator.Identified.self,
			Backup.Identified.self,
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
		store.delete(Delete<User.Identified>(nil))
		store.delete(Delete<Collaborator.Identified>(nil))
		store.delete(Delete<Backup.Identified>(nil))
		store.delete(Delete<Tagging>(nil))
	}
}
