// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Collection
import struct Catena.IDFields
import struct Schemata.Projection
import protocol Catena.Representable
import protocol Catenoid.Row
import protocol Catenoid.Model
import protocol DewdropService.CollectionFields

public struct ChildCollectionRow: CollectionFields {
	public let id: Collection.ID
	public let parentID: Collection.ID
	public let title: String
	public let count: Int
	public let isShared: Bool
	public let sortIndex: Int
}

// MARK: -
public extension ChildCollectionRow {
	init(
		collection: some Representable<Value, IdentifiedValue>,
		parentID: Collection.ID
	) {
		let value = collection.value
		self.init(
			id: collection.id,
			parentID: parentID,
			title: value.title,
			count: value.count,
			isShared: value.isShared,
			sortIndex: value.sortIndex
		)
	}
}

// MARK: -
extension ChildCollectionRow: Row {
	// MARK: Valued
	public typealias Value = Collection

	// MARK: Representable
	public var value: Value {
		.init(
			title: title,
			count: count,
			coverURL: nil, // TODO
			colorString: nil, // TODO
			view: .grid, // TODO
			access: .init(level: .owner, isDraggable: true), // TODO
			sortIndex: sortIndex,
			isPublic: false, // TODO
			isShared: isShared,
			isExpanded: false, // TODO
			creationDate: .init(), // TODO
			updateDate: .init() // TODO
		)
	}

	// MARK: ModelProjection
	public static let projection = Projection<Self.Model, Self>(
		Self.init,
		\.id,
		\.parentID,
		\.value.title,
		\.value.count,
		\.value.isShared,
		\.value.sortIndex
	)
}

extension ChildCollectionRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Collection.Identified> {
		[
			\.parentID == parentID,
			\.value.title == title,
			\.value.count == count,
			\.value.isShared == isShared,
			\.value.sortIndex == sortIndex,
		]
	}
}

// MARK: -
private extension ChildCollectionRow {
	#if swift(<6.0)
	@Sendable
	#endif
	init(
		id: Collection.ID,
		parentID: Collection.ID?,
		title: String,
		count: Int,
		isShared: Bool,
		sortIndex: Int
	) {
		self.id = id
		self.parentID = parentID!
		self.title = title
		self.count = count
		self.isShared = isShared
		self.sortIndex = sortIndex
	}
}
