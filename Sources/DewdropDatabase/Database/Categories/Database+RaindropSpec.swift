// Copyright © Fleuronic LLC. All rights reserved.

import enum Catenoid.UngenerableIdentifier
import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct Dewdrop.Media
import struct Dewdrop.Highlight
import struct Foundation.URL
import struct Foundation.Date
import protocol DewdropService.RaindropSpec
import protocol Catena.Scoped

extension Database: RaindropSpec {
	#if swift(<6.0)
	public typealias RaindropFetchFields = RaindropSpecifiedFields
	public typealias RaindropListFields = RaindropSpecifiedFields
	public typealias RaindropCreationFields = Never
	#endif

	public func fetchRaindrop(with id: Raindrop.ID) async -> SingleResult<RaindropSpecifiedFields?> {
		await fetch(with: id).map(\.first)
	}

	public func listRaindrops(inCollectionWith id: Collection.ID = .all, searchingFor query: String? = nil, sortedBy sort: Raindrop.Sort? = nil, onPage page: Int? = nil, listing raindropsPerPage: Int? = nil) async -> Results<RaindropSpecifiedFields> {
		await fetch(where: .isInCollection(with: id, searchingFor: query))
	}

	public func findSuggestions(forRaindropWith id: Raindrop.InvalidID) async -> ImpossibleResult {
		// Cannot use database to find suggestions
	}

	public func removeRaindrop(with id: Raindrop.ID) async -> SingleResult<Raindrop.ID?> {
		await removeRaindrops(fromCollectionWith: .all, matching: [id]).map(\.first)
	}

	public func removeRaindrops(fromCollectionWith collectionID: Collection.ID, matching ids: [Raindrop.ID]? = nil, searchingFor search: String? = nil) async -> Results<Raindrop.ID> {
		switch (ids, collectionID) {
		case (let ids?, .all):
			return await delete(with: ids)
		case (let ids?, _):
			return await removeRaindrops(fromCollectionWith: collectionID, matching: ids)
		case (let ids?, .trash):
			if await ids.count == trashCount {
				fallthrough
			} else {
				return await delete(with: ids)
			}
		case (nil, .trash):
			return await removeRaindrops(fromCollectionWith: .trash).flatMap { ids in
				await removeCollection(with: .trash).map { _ in ids }
			}
		case (nil, _):
			return await removeRaindrops(fromCollectionWith: collectionID)
		}
	}

	public func createRaindrop(
		id: Raindrop.UngenerableID,
		url: URL,
		title: String?,
		itemType: Raindrop.ItemType?,
		excerpt: String?,
		coverURL: URL?,
		order: Int?,
		collectionID: Collection.ID?,
		tagNames: [String]?,
		media: [Media]?,
		highlightContents: [Highlight.Content]? = nil,
		isFavorite: Bool?,
		creationDate: Date?,
		updateDate: Date?,
		shouldParse: Bool
	) -> ImpossibleResult {
		// Can’t generate ID using database
	}
}

private extension Database {
	var trashCount: Int {
		get async {
			await fetch(where: .isInCollection(with: .trash))
				.map { $0 as [Raindrop.IDFields] }
				.map(\.count)
				.value
		}
	}

	func removeRaindrops(fromCollectionWith collectionID: Collection.ID) async -> Results<Raindrop.ID> {
		await fetch(where: .isInCollection(with: collectionID))
			.map { $0 as [Raindrop.IDFields] }
			.map { $0.map(\.id) }
			.flatMap(delete)
	}

	func removeRaindrops(fromCollectionWith collectionID: Collection.ID, matching ids: [Raindrop.ID]) async -> Results<Raindrop.ID> {
		await fetch(where: .isInCollection(with: collectionID))
			.map { $0 as [Raindrop.IDFields] }
			.map { $0.map(\.id) }
			.map(Set.init)
			.map { $0.intersection(ids) }
			.map(Array.init)
			.flatMap(delete)
	}
}
