// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import struct Dewdrop.Highlight
import struct Dewdrop.Raindrop
import struct DewdropService.IdentifiedHighlight
import struct PersistDB.Ordering
import protocol PersistDB.Model
import protocol Catenoid.Model

extension Highlight.Identified: Schemata.Model {
	// MARK: Model
	public enum Path: String {
		case id
		case text
		case raindrop
	}

	public static let schema = Schema(
		Self.init,
		\.id * .id,
		\.value.content.text * .text,
		\.raindrop --> .raindrop
	)

	public static let schemaName = "highlights"
}

// MARK: -
extension Highlight.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.id, ascending: true)]
	}
}

// MARK: -
extension [Highlight.Identified] {
	// MARK: Model
	public static var schema: Schema<Self> {
		let id = \Self.id * .id
		let text = \Self.value.content.text * .text

		return .init(
			Self.init,
			id,
			text
		)
	}
}

// MARK: -
extension Predicate<Highlight.Identified> {
	static func isInRaindrop(with id: Raindrop.ID) -> Self {
		\.raindrop.id == id
	}
}
