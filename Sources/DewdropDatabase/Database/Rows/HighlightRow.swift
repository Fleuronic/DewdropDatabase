// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Highlight
import struct Dewdrop.Raindrop
import struct Dewdrop.User
import struct Schemata.Projection
import struct Foundation.Date
import protocol Catena.Representable
import protocol Catenoid.Row
import protocol Catenoid.Model
import protocol DewdropService.HighlightFields

public struct HighlightRow: HighlightFields {
	public let id: Highlight.ID
	public let text: String
	public let color: Highlight.Color
	public let note: String?
	public let creationDate: Date
	public let updateDate: Date
	public let raindrop: Raindrop.IDFields
	public let creator: User.IDFields
}

// MARK: -
public extension HighlightRow {
	init(
		highlight: some Representable<Value, IdentifiedValue>,
		raindropID: Raindrop.ID,
		creatorID: User.ID
	) {
		let value = highlight.value
		self.init(
			id: highlight.id,
			raindropID: raindropID,
			creatorID: creatorID,
			text: value.content.text,
			color: value.content.color,
			note: value.content.note,
			creationDate: value.creationDate,
			updateDate: value.updateDate
		)
	}
}

// MARK: -
extension HighlightRow: Row {
	// MARK: Valued
	public typealias Value = Highlight

	// MARK: Representable
	public var value: Value {
		.init(
			content: .init(
				text: text,
				color: color,
				note: note
			),
			title: nil,
			creationDate: creationDate,
			updateDate: updateDate
		)
	}

	// MARK: ModelProjection
	public static let projection = Projection<Self.Model, Self>(
		Self.init,
		\.id,
		\.raindrop.id,
		\.creator.id,
		\.value.content.text,
		\.value.content.color,
		\.value.content.note,
		\.value.creationDate,
		\.value.updateDate
	)
}

// MARK: -
extension HighlightRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Highlight.Identified> {
		[
			\.value.content.text == text,
			\.value.content.color == color,
			\.value.content.note == note,
			\.value.creationDate == creationDate,
			\.value.updateDate == updateDate,
			\.raindrop == raindrop.id,
			\.creator == creator.id
		]
	}
}

// MARK: -
private extension HighlightRow {
	#if swift(<6.0)
	@Sendable
	#endif
	init(
		id: Highlight.ID,
		raindropID: Raindrop.ID,
		creatorID: User.ID,
		text: String,
		color: Highlight.Color,
		note: String?,
		creationDate: Date,
		updateDate: Date
	) {
		self.init(
			id: id,
			text: text,
			color: color,
			note: note,
			creationDate: creationDate,
			updateDate: updateDate,
			raindrop: .init(id: raindropID),
			creator: .init(id: creatorID)
		)
	}
}
