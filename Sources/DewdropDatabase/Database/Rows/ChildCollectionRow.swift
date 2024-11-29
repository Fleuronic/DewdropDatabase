// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Collection
import struct Catena.IDFields
import struct Schemata.Projection
import struct Foundation.URL
import struct Foundation.Date
import protocol Catena.Representable
import protocol Catenoid.Row
import protocol Catenoid.Model
import protocol DewdropService.CollectionFields

public struct ChildCollectionRow: CollectionFields {
	public let id: Collection.ID
	public let parentID: Collection.ID
	public let title: String
	public let count: Int
	public let coverURL: URL?
	public let colorString: String?
	public let view: Collection.View
	public let accessLevel: Collection.Access.Level
	public let isDraggable: Bool
	public let sortIndex: Int
	public let isPublic: Bool
	public let isShared: Bool
	public let isExpanded: Bool
	public let creationDate: Date
	public let updateDate: Date
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
			coverURL: value.coverURL,
			colorString: value.colorString,
			view: value.view!,
			accessLevel: value.access.level,
			isDraggable: value.access.isDraggable,
			sortIndex: value.sortIndex,
			isPublic: value.isPublic,
			isShared: value.isShared,
			isExpanded: value.isExpanded,
			creationDate: value.creationDate!,
			updateDate: value.updateDate!
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
			coverURL: coverURL,
			colorString: colorString,
			view: view,
			access: .init(level: accessLevel, isDraggable: isDraggable),
			sortIndex: sortIndex,
			isPublic: isPublic,
			isShared: isShared,
			isExpanded: isExpanded,
			creationDate: creationDate,
			updateDate: updateDate
		)
	}

	// MARK: ModelProjection
	public static let projection = Projection<Self.Model, Self>(
		Self.init,
		\.id,
		\.parentID!,
		\.value.title,
		\.value.count,
		\.value.coverURL,
		\.value.colorString,
		\.value.view!,
		\.value.access.level,
		\.value.access.isDraggable,
		\.value.sortIndex,
		\.value.isPublic,
		\.value.isShared,
		\.value.isExpanded,
		\.value.creationDate!,
		\.value.updateDate!
	)
}

extension ChildCollectionRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Collection.Identified> {
		[
			\.parentID == parentID,
			\.value.title == title,
			\.value.count == count,
			\.value.coverURL == coverURL,
			\.value.colorString == colorString,
			\.value.view == view,
			\.value.access.level == accessLevel,
			\.value.access.isDraggable == isDraggable,
			\.value.sortIndex == sortIndex,
			\.value.isPublic == isPublic,
			\.value.isShared == isShared,
			\.value.isExpanded == isExpanded,
			\.value.creationDate == creationDate,
			\.value.updateDate == updateDate
		]
	}
}
