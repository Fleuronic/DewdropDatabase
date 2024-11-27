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
	public let parentID: Collection.ID?
	public let title: String
	public let count: Int
	public let view: Collection.View
	public let sortIndex: Int
	public let isShared: Bool
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
			view: value.view,
			sortIndex: value.sortIndex,
			isShared: value.isShared
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
			view: view,
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
		\.value.view,
		\.value.sortIndex,
		\.value.isShared
	)
}

extension ChildCollectionRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Collection.Identified> {
		[
			\.parentID == parentID,
			\.value.title == title,
			\.value.count == count,
//			\.value.coverURL ==
//			 case colorString = "color_string"
			\.value.view == view,
			\.value.sortIndex == sortIndex,
			\.value.isPublic == false,
			\.value.isShared == isShared,
			\.value.isExpanded == false,
			\.value.creationDate == .init(),
			\.value.updateDate == .init()
		]
	}
}
