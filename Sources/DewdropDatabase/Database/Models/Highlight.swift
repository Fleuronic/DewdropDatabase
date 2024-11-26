// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import struct Dewdrop.Highlight
import struct Dewdrop.Raindrop
import struct DewdropService.IdentifiedHighlight
import protocol Catenoid.Model

extension Highlight.Identified: Schemata.Model {
	// MARK: Model
	public enum Path: String {
		case id
		case text
		case creationDate
		case updateDate
		case raindrop
	}

	public static let schema = Schema(
		Self.init,
		\.id * .id,
		\.value.content.text * .text,
		\.value.creationDate * .creationDate,
		\.value.updateDate * .updateDate,
		\.raindrop --> .raindrop
	)

	public static let schemaName = "highlights"
}

// MARK: -
extension Highlight.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.id)]
	}
}

// MARK: -
extension Predicate<Highlight.Identified> {
	static func isInRaindrop(with id: Raindrop.ID) -> Self {
		\.raindrop.id == id
	}
}
