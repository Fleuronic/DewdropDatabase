// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Group
import struct Dewdrop.Collection
import struct Dewdrop.Filter
import struct Dewdrop.Raindrop
import struct Dewdrop.Highlight
import protocol DewdropService.GroupFields
import protocol DewdropService.CollectionFields
import protocol DewdropService.FilterFields
import protocol DewdropService.RaindropFields
import protocol Schemata.AnyModel
import protocol Catenoid.Database
import protocol Catenoid.Fields

public struct Database<
	RaindropListFields: RaindropFields & Fields,
	CollectionListFields: CollectionFields & Fields,
	ChildCollectionListFields: CollectionFields & Fields,
	SystemCollectionListFields: CollectionFields & Fields,
	GroupListFields: GroupFields & Fields,
	FilterListFields: FilterFields & Fields
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
			Highlight.Identified.self
		]
	}

	public mutating func clear() async throws {
		try Store.destroy()
		store = try await Self.createStore()
	}
}
