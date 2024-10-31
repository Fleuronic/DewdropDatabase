// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Raindrop
import protocol DewdropService.HighlightSpec
import protocol Catenoid.Fields

extension Database: HighlightSpec {
	public func listHighlights(onPage page: Int? = nil, listing highlightsPerPage: Int? = nil) async -> Results<HighlightListFields> {
		await fetch()
	}

	public func listHighlights(ofRaindropWith id: Raindrop.ID) async -> Results<HighlightListFields> {
		await fetch(where: .isInRaindrop(with: id))
	}
}
