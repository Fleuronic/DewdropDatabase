// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.Highlight
import struct Dewdrop.Raindrop
import struct Schemata.Projection
import struct Foundation.Date
import protocol Catena.Representable
import protocol Catenoid.Row
import protocol Catenoid.Model
import protocol DewdropService.HighlightFields

public struct HighlightRow: HighlightFields {
	public let id: Highlight.ID
	public let text: String
	public let creationDate: Date
	public let updateDate: Date
	public let raindrop: Raindrop.IDFields
}

// MARK: -
public extension HighlightRow {
	init(
		highlight: some Representable<Value, IdentifiedValue>,
		raindropID: Raindrop.ID
	) {
		let value = highlight.value
		self.init(
			id: highlight.id,
			text: value.content.text,
			creationDate: value.creationDate,
			updateDate: value.updateDate,
			raindropID: raindropID
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
				text: text
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
		\.value.content.text,
		\.value.creationDate,
		\.value.updateDate,
		\.raindrop.id
	)
}

// MARK: -
extension HighlightRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Highlight.Identified> {
		[
			\.value.content.text == text,
			\.value.creationDate == creationDate,
			\.value.updateDate == updateDate,
			\.raindrop == raindrop.id
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
	   text: String,
	   creationDate: Date,
	   updateDate: Date,
	   raindropID: Raindrop.ID
   ) {
	   self.id = id
	   self.text = text
	   self.creationDate = creationDate
	   self.updateDate = updateDate

	   raindrop = .init(id: raindropID)
   }
}
