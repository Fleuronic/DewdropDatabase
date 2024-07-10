// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Group
import struct Dewdrop.Collection
import struct Schemata.Projection
import struct Catena.IDFields
import protocol Catenoid.Fields
import protocol DewdropService.GroupFields

public struct GroupListFields {
	public let title: String
	public let sortIndex: Int
	public let collections: [CollectionListFields]

	// MARK: ModelProjection
	public static let projection = Projection<Model, Self>(
		Self.init,
		\.id,
		\.value.sortIndex,
		\.collections.id,
		\.collections.value.title,
		\.collections.value.count
	)
}

// MARK
extension GroupListFields: Fields {
	// MARK: ModelProjection
	public var id: Group.ID { .init(rawValue: title) }

	// MARK: Fields
	public static func merge(lhs: Self, rhs: Self) -> Self {
		let id = lhs.id
		let sortIndex = lhs.sortIndex
		let lhs = lhs.collections
		let rhs = rhs.collections
		
		return .init(
			id: id,
			sortIndex: sortIndex,
			collectionIDs: lhs.map(\.id) + rhs.map(\.id),
			collectionTitles: lhs.map(\.title) + rhs.map(\.title),
			collectionCounts: lhs.map(\.count) + rhs.map(\.count)
		)
	}
}

// MARK
extension GroupListFields: GroupFields {
	// MARK: Fields
	public typealias Model = Group.Identified
}

// MARK: -
private extension GroupListFields {
	init(
		id: Group.ID,
		sortIndex: Int,
		collectionIDs: [Collection.ID],
		collectionTitles: [String],
		collectionCounts: [Int]
	) {
		self.sortIndex = sortIndex

		title = id.rawValue
		collections = collectionIDs.enumerated().map { index, id in
			.init(
				id: id,
				parentID: nil,
				title: collectionTitles[index],
				count: collectionCounts[index],
				group: nil
			)
		}
	}
}