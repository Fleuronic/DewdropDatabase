// Copyright © Fleuronic LLC. All rights reserved.


@preconcurrency import PersistDB

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct Dewdrop.Group
import protocol Schemata.AnyModel
import protocol Catenoid.Database

public struct Database {
	public private(set) var store: Store<ReadWrite>

	public init() async {
		store = try! await Self.createStore()
	}
}

// MARK: -
extension Database: Catenoid.Database {
	public static let types: [AnyModel.Type] = [
		Raindrop.Identified.self,
		Collection.Identified.self,
		Group.Identified.self
	]

	public mutating func clear() async throws {
		try Store.destroy()
		store = try await Self.createStore()
	}
}
