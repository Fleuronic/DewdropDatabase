// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import protocol DewdropService.HighlightSpec
import protocol Catena.Scoped

extension Database: HighlightSpec {
	public func listHighlights(ofRaindropWith id: Raindrop.ID) async -> SingleResult<RaindropHighlightResultFields> {
		// TODO
		fatalError()
	}

	public func listHighlights(inCollectionWith id: Collection.ID = .all, onPage page: Int? = nil, listing highlightsPerPage: Int? = nil) async -> Results<HighlightResultFields> {
		// TODO
		await fetch()
	}
}
