// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Collection
import struct Dewdrop.Group
import struct Schemata.Projection
import protocol Catena.Representable
import protocol Catenoid.Row
import protocol Catenoid.Model
import protocol DewdropService.CollectionFields

public struct RootCollectionRow: CollectionFields {
	public let id: Collection.ID
	public let title: String
	public let count: Int
	public let isShared: Bool
	public let sortIndex: Int
	public let group: Group.IDFields?
}

// MARK: -
public extension RootCollectionRow {
	init(
		collection: some Representable<Value, IdentifiedValue>,
		groupID: Group.ID
	) {
		let value = collection.value
		self.init(
			id: collection.id,
			title: value.title,
			count: value.count,
			isShared: value.isShared,
			sortIndex: value.sortIndex,
			groupID: groupID
		)
	}
}

// MARK: -
extension RootCollectionRow: Row {
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
		\.value.title,
		\.value.count,
		\.value.isShared,
		\.value.sortIndex,
		\.group.id
	)
}

extension RootCollectionRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Collection.Identified> {
		[
			\.value.title == title,
			\.value.count == count,
			\.value.isShared == isShared,
			\.value.sortIndex == sortIndex,
			\.group == group?.id
		]
	}
}

// MARK: -
private extension RootCollectionRow {
	#if swift(<6.0)
	@Sendable
	#endif
	init(
		id: Collection.ID,
		title: String,
		count: Int,
		isShared: Bool,
		sortIndex: Int,
		groupID: Group.ID
	) {
		self.id = id
		self.title = title
		self.count = count
		self.isShared = isShared
		self.sortIndex = sortIndex

		group = .init(id: groupID)
	}
}
