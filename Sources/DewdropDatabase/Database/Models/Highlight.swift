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
		case color
		case note
		case creationDate
		case updateDate
		case raindrop
		case creator
	}

	public static var schema: Schema<Self> {
		let id = \Self.id * .id
		let text = \Self.value.content.text * .text
		let color = \Self.value.content.color * .color
		let note = \Self.value.content.note * .note
		let value = \Self.value.creationDate * .creationDate
		let updateDate = \Self.value.updateDate * .updateDate
		let raindrop = \Self.raindrop --> .raindrop
		let creator = \Self.creator --> .creator

		return .init(
			Self.init,
			id,
			text,
			color,
			note,
			value,
			updateDate,
			raindrop,
			creator
		)
	}

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
