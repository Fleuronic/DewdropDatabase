// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct Dewdrop.Media
import struct Dewdrop.Highlight
import struct Foundation.URL
import struct Foundation.Date
import protocol DewdropService.RaindropSpec
import protocol Catena.Scoped

extension Database/*: RaindropSpec*/ {
	#if swift(<6.0)
	public typealias RaindropFetchFields = RaindropSpecifiedFields
	public typealias RaindropListFields = RaindropSpecifiedFields
	public typealias RaindropCreationFields = Never
	#endif

	public func fetchRaindrop(with id: Raindrop.ID) async -> SingleResult<RaindropSpecifiedFields?> {
		await fetch(with: id).map(\.first)
	}

	public func fetchContents(ofRaindropWith id: Raindrop.InvalidID) async -> ImpossibleResult<Never> {
		// Cannot fetch raindrop contents using database
	}

	public func listRaindrops(inCollectionWith id: Collection.ID = .all, searchingFor query: String? = nil, sortedBy sort: Raindrop.Sort? = nil, onPage page: Int? = nil, listing raindropsPerPage: Int? = nil) async -> Results<RaindropSpecifiedFields> {
		// TODO: Page, listing
		await fetch(where: .isInCollection(with: id, searchingFor: query))
	}

	public func createRaindrop(_ id: Raindrop.UngenerableID, for url: URL, with parameters: Raindrop.CreationParameters) async -> ImpossibleResult<Raindrop> {
		// Cannot generate ID using database
	}

	public func createRaindrops(_ ids: Raindrop.UngenerableIDs, for urls: [URL], with parameters: [Raindrop.CreationParameters]) async -> ImpossibleResults<Raindrop> {
		// Cannot generate IDs using database
	}

	public func uploadCover(forRaindropWith id: Raindrop.InvalidID, usingFileAt url: URL) async -> ImpossibleResult<Never> {
		// Cannot use database to upload cover
	}

	public func findSuggestions(forRaindropWith id: Raindrop.InvalidID) async -> ImpossibleResult<Never> {
		// Cannot use database to find suggestions
	}

	public func findSuggestions(forRaindropWith id: Raindrop.UngenerableID, createdFor url: URL) async -> ImpossibleResult<Never> {
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
}
// MARK: -
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
