// Copyright © Fleuronic LLC. All rights reserved.

import enum Catenoid.UngenerableIdentifier
import enum Dewdrop.ItemType
import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct Foundation.URL
import struct Foundation.Date
import protocol DewdropService.RaindropSpec
import protocol Catena.Scoped

extension Database: RaindropSpec {
	public func fetchRaindrop(with id: Raindrop.ID) async -> SingleResult<RaindropSpecifiedFields> {
		fatalError()
	}

	public func listRaindrops(inCollectionWith id: Collection.ID = .all, searchingFor query: String? = nil, sortedBy sort: Raindrop.Sort? = nil, onPage page: Int? = nil, listing raindropsPerPage: Int? = nil) async -> Results<RaindropSpecifiedFields> {
		await fetch(where: .isInCollection(with: id, searchingFor: query))
	}

	public func findSuggestions(forRaindropWith id: Raindrop.InvalidID) async -> NoResult {
		// Cannot use database to find suggestions
	}

	public func removeRaindrop(with id: Raindrop.ID) async -> Results<Raindrop.ID> {
		await delete(with: [id])
	}

	public func createRaindrop(
		id: Raindrop.UngenerableID,
		url: URL,
		title: String?,
		itemType: ItemType?,
		excerpt: String?,
		coverURL: URL?,
		order: Int?,
		collectionID: Collection.ID?,
		tagNames: [String]?,
	//	media: [Media]?,
	//	highlightContents: [Highlight.Content]?,
		isFavorite: Bool?
//		creationDate: Date?,
//		updateDate: Date?,
//		shouldParse: Bool
	) -> SingleResult<RaindropSpecifiedFields> {
		// Can’t generate ID using database
	}
}
