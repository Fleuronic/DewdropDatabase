// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Collection
import struct Dewdrop.Group
import struct Schemata.Projection
import struct Foundation.URL
import struct Foundation.Date
import protocol Catena.Representable
import protocol Catenoid.Row
import protocol Catenoid.Model
import protocol DewdropService.CollectionFields

public struct RootCollectionRow: CollectionFields {
	public let id: Collection.ID
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
extension RootCollectionRow: Row {
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
		\.group.id,
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

extension RootCollectionRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Collection.Identified> {
		[
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
			\.value.updateDate == updateDate,
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
		coverURL: URL?,
		colorString: String?,
		view: Collection.View,
		accessLevel: Collection.Access.Level,
		isDraggable: Bool,
		sortIndex: Int,
		isPublic: Bool,
		isShared: Bool,
		isExpanded: Bool,
		creationDate: Date,
		updateDate: Date
	) {
		self.init(
			id: id,
			title: title,
			count: count,
			coverURL: coverURL,
			colorString: colorString,
			view: view,
			accessLevel: accessLevel,
			isDraggable: isDraggable,
			sortIndex: sortIndex,
			isPublic: isPublic,
			isShared: isShared,
			isExpanded: isExpanded,
			creationDate: creationDate,
			updateDate: updateDate,
			group: .init(id: groupID)
		)
	}
}
