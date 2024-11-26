// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Group
import struct Dewdrop.Collection
import struct Catena.IDFields
import struct Schemata.Projection
import protocol Catena.Representable
import protocol Catenoid.Row
import protocol Catenoid.Model
import protocol DewdropService.GroupFields

public struct GroupRow: GroupFields {
	public let title: String
	public let isHidden: Bool
	public let sortIndex: Int
	public let collections: [RootCollectionRow]
}

// MARK: -
public extension GroupRow {
	init(
		group: some Representable<Value, IdentifiedValue>,
		collections: [RootCollectionRow]
	) {
		let value = group.value
		self.init(
			title: value.title,
			isHidden: value.isHidden,
			sortIndex: value.sortIndex,
			collections: collections
		)
	}
}

// MARK: -
extension GroupRow: Row {
	// MARK: Valued
	public typealias Value = Group

	// MARK: Representable
	public var value: Group {
		.init(
			title: title,
			sortIndex: sortIndex,
			isHidden: isHidden
		)
	}

	// MARK: ModelProjection
	public var id: Group.ID { .init(rawValue: sortIndex) }

	// MARK: ModelProjection
	public static let projection = Projection<Self.Model, Self>(
		Self.init,
		\.id,
		\.value.title,
		\.value.isHidden,
		\.collections.id,
		\.collections.value.title,
		\.collections.value.count,
		\.collections.value.isShared,
		\.collections.value.sortIndex
	)

	// MARK: Fields
	public static func merge(lhs: Self, rhs: Self) -> Self {
		let id = lhs.id
		let title = lhs.title
		let isHidden = lhs.isHidden
		let lhs = lhs.collections
		let rhs = rhs.collections

		return .init(
			id: id,
			title: title,
			isHidden: isHidden,
			collectionIDs: lhs.map(\.id) + rhs.map(\.id),
			collectionTitles: lhs.map(\.title) + rhs.map(\.title),
			collectionCounts: lhs.map(\.count) + rhs.map(\.count),
			collectionIsSharedFlags: lhs.map(\.isShared) + rhs.map(\.isShared),
			collectionSortIndices: lhs.map(\.sortIndex) + rhs.map(\.sortIndex)
		)
	}
}

extension GroupRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Group.Identified> {
		[
			\.value.title == title,
			\.value.isHidden == isHidden
		]
	}
}

// MARK: -
private extension GroupRow {
	#if swift(<6.0)
	@Sendable
	#endif
	init(
		id: Group.ID,
		title: String,
		isHidden: Bool,
		collectionIDs: [Collection.ID],
		collectionTitles: [String],
		collectionCounts: [Int],
		collectionIsSharedFlags: [Bool],
		collectionSortIndices: [Int]
	) {
		self.title = title
		self.isHidden = isHidden
		sortIndex = id.rawValue

		let groupID = id
		collections = collectionIDs.enumerated().map { index, id in
			.init(
				id: id,
				title: collectionTitles[index],
				count: collectionCounts[index],
				isShared: collectionIsSharedFlags[index],
				sortIndex: collectionSortIndices[index],
				group: .init(id: groupID)
			)
		}
	}
}
