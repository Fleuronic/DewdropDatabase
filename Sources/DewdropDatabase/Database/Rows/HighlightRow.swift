// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.Highlight
import struct Dewdrop.Raindrop
import protocol Catenoid.Fields
import protocol DewdropService.HighlightFields

public struct HighlightRow: HighlightFields {
	public let id: Highlight.ID
	public let raindropID: Raindrop.ID

	#if swift(<6.0)
	@Sendable init(
		id: Highlight.ID,
		raindropID: Raindrop.ID
	) {
		self.id = id
		self.raindropID = raindropID
	}
	#endif
}

// MARK
extension HighlightRow: Fields {
	// MARK: ModelProjection
	public static let projection = Projection<Self.Model, Self>(
		Self.init,
		\.id,
		\.raindrop.id
	)
}
