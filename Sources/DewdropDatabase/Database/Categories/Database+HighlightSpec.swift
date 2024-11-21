// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import protocol DewdropService.HighlightSpec
import protocol Catena.Scoped

extension Database: HighlightSpec {
	#if swift(<6.0)
	public typealias HighlightListFields = HighlightSpecifiedFields
	public typealias RaindropHighlightListFields = RaindropHighlightSpecifiedFields
	#endif

	public func listHighlights(ofRaindropWith id: Raindrop.ID) async -> SingleResult<RaindropHighlightSpecifiedFields> {
		// TODO
		fatalError()
	}

	public func listHighlights(inCollectionWith id: Collection.ID = .all, onPage page: Int? = nil, listing highlightsPerPage: Int? = nil) async -> Results<HighlightSpecifiedFields> {
		// TODO
		await fetch()
	}
}
