// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Highlight
import struct Dewdrop.Raindrop
import protocol DewdropService.HighlightSpec
import protocol Catena.Scoped
import protocol Catenoid.Database
import protocol Catenoid.Fields

extension Database: HighlightSpec {
	public func listHighlights(onPage page: Int? = nil, listing highlightsPerPage: Int? = nil) async -> Self.Result<[HighlightListFields]> {
		await fetch()
	}

	public func listHighlights(ofRaindropWith id: Raindrop.ID) async -> Self.Result<[HighlightListFields]> {
		await fetch(where: .isInRaindrop(with: id))
	}
}
