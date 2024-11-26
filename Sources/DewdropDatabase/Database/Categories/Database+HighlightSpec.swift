// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB // TODO

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct Catena.IDFields
import protocol DewdropService.HighlightSpec
import protocol Catena.Scoped

extension Database: HighlightSpec {
	#if swift(<6.0)
	public typealias HighlightListFields = HighlightSpecifiedFields
	public typealias HighlightInRaindropListFields = HighlightInRaindropSpecifiedFields
	#endif

	public func listHighlights(ofRaindropWith id: Raindrop.ID) async -> Results<HighlightInRaindropSpecifiedFields> {
		await fetch(where: .isInRaindrop(with: id))
	}

	public func listHighlights(inCollectionWith id: Collection.ID = .all, onPage page: Int? = nil, listing highlightsPerPage: Int? = nil) async -> Results<HighlightSpecifiedFields> {
		await self
			.specifyingRaindropFields(IDFields.self)
			.listRaindrops(inCollectionWith: id)
			.map { $0 as [Raindrop.IDFields] }
			.map { $0.map(\.id) }
			.flatMap { await fetch(where: $0.contains(\.raindrop.id)) }
	}
}
