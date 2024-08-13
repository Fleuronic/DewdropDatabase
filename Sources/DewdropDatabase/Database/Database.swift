// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Group
import struct Dewdrop.Collection
import struct Dewdrop.Filter
import struct Dewdrop.Raindrop
import protocol DewdropService.GroupFields
import protocol DewdropService.CollectionFields
import protocol DewdropService.FilterFields
import protocol DewdropService.RaindropFields
import protocol Schemata.AnyModel
import protocol Catenoid.Database
import protocol Catenoid.Fields

public struct Database<
	GroupListFields: GroupFields & Fields,
	CollectionListFields: CollectionFields & Fields,
	ChildCollectionListFields: CollectionFields & Fields,
	SystemCollectionListFields: CollectionFields & Fields,
	FilterListFields: FilterFields & Fields,
	RaindropListFields: RaindropFields & Fields
>: @unchecked Sendable {
	public private(set) var store: Store<ReadWrite>

	public init(
		
	) async {
		store = try! await Self.createStore()
	}
}

// MARK: -
extension Database: Catenoid.Database {
	public static var types: [AnyModel.Type] {
		[
			Group.Identified.self,
			Collection.Identified.self,
			Filter.Identified.self,
			Raindrop.Identified.self
		]
	}

	public mutating func clear() async throws {
		try Store.destroy()
		store = try await Self.createStore()
	}
}
