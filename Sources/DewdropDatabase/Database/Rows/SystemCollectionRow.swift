// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Collection
import struct Schemata.Projection
import protocol Catena.Representable
import protocol Catenoid.Row
import protocol Catenoid.Model
import protocol DewdropService.CollectionFields

public struct SystemCollectionRow: CollectionFields {
	public let id: Collection.ID
	public let title: String
	public let count: Int
	public let sortIndex: Int

	#if swift(<6.0)
	@Sendable init(
		id: Collection.ID,
		title: String,
		count: Int,
		sortIndex: Int
	) {
		self.id = id
		self.title = title
		self.count = count
		self.sortIndex = sortIndex
	}
	#endif
}

// MARK: -
public extension SystemCollectionRow {
	init(
		id: Collection.ID,
		count: Int
	) {
		self.init(
			id: id,
			title: Collection.systemTitle(forCollectionWith: id)!,
			count: count,
			sortIndex: id.rawValue
		)
	}
}

// MARK: -
extension SystemCollectionRow: Row {
	// MARK: Valued
	public typealias Value = Collection

	// MARK: Representable
	public var value: Value {
		.init(
			title: title,
			count: count,
			coverURL: nil,
			colorString: nil,
			view: nil,
			access: .init(
				level: .owner,
				isDraggable: false
			),
			sortIndex: sortIndex,
			isPublic: false,
			isShared: false,
			isExpanded: false,
			creationDate: nil,
			updateDate: nil
		)
	}

	// MARK: ModelProjection
	public static let projection = Projection<Model, Self>(
		Self.init,
		\.id,
		\.value.title,
		\.value.count,
		\.value.sortIndex
	)
}

extension SystemCollectionRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Collection.Identified> {
		[
			\.value.title == title,
			\.value.count == count,
			\.value.sortIndex == sortIndex,
			\.value.access.level == .owner,
			\.value.access.isDraggable == false,
			\.value.isPublic == false,
			\.value.isShared == false,
			\.value.isExpanded == false
		]
	}
}
