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
			groupID: groupID,
			title: value.title,
			count: value.count,
			isShared: value.isShared,
			sortIndex: value.sortIndex
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
		\.group.id,
		\.value.title,
		\.value.count,
		\.value.isShared,
		\.value.sortIndex
	)
}

extension RootCollectionRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Collection.Identified> {
		[
			\.value.title == title,
			\.value.count == count,
			\.value.view == .list,
			\.value.sortIndex == sortIndex,
			\.value.isPublic == false,
			\.value.isShared == isShared,
			\.value.isExpanded == false,
			\.value.creationDate == .init(),
			\.value.updateDate == .init(),
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
		groupID: Group.ID,
		title: String,
		count: Int,
		isShared: Bool,
		sortIndex: Int
	) {
		self.init(
			id: id,
			title: title,
			count: count,
			isShared: isShared,
			sortIndex: sortIndex,
			group: .init(id: groupID)
		)
	}
}
