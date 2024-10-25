// Copyright © Fleuronic LLC. All rights reserved.

public import struct Dewdrop.Raindrop
public import protocol DewdropService.HighlightSpec
public import protocol Catenoid.Fields

extension Database: HighlightSpec {
	public func listHighlights(onPage page: Int? = nil, listing highlightsPerPage: Int? = nil) async -> Self.Result<[HighlightListFields]> {
		await fetch()
	}

	public func listHighlights(ofRaindropWith id: Raindrop.ID) async -> Self.Result<[HighlightListFields]> {
		await fetch(where: .isInRaindrop(with: id))
	}
}
