// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct Dewdrop.Filter
import struct DewdropService.IdentifiedRaindrop
import protocol Catenoid.Model

public extension Raindrop {
	typealias InvalidID = Identified.InvalidID
	typealias UngenerableID = Identified.UngenerableID
}

// MARK: -
extension Raindrop.Identified: Schemata.Model {
	// MARK: Model
	public enum Path: String {
		case id
		case url
		case title
		case itemType = "item_type"
		case excerpt
		case domain
		case coverURL = "cover_url"
		case note
		case isFavorite = "favorite"
		case isBroken = "broken"
		case creationDate = "creation_date"
		case updateDate = "update_date"
		case collection
	}

	public static var schema: Schema<Self> {
		let id = \Self.id * .id
		let url = \Self.value.url * .url
		let title = \Self.value.title * .title
		let itemType = \Self.value.itemType * .itemType
		let excerpt = \Self.value.excerpt * .excerpt
		let domain = \Self.value.domain * .domain
		let coverURL = \Self.value.coverURL * .coverURL
		let note = \Self.value.note * .note
		let isFavorite = \Self.value.isFavorite * .isFavorite
		let isBroken = \Self.value.isBroken * .isBroken
		let creationDate = \Self.value.creationDate * .creationDate
		let updateDate = \Self.value.updateDate * .updateDate
		let collection = \Self.collection -?> .collection

		return .init(
			Self.init,
			id,
			url,
			title,
			itemType,
			excerpt,
			domain,
			coverURL,
			note,
			isFavorite,
			isBroken,
			creationDate,
			updateDate,
			collection
		)
	}

	public static let schemaName = "raindrops"
}

// MARK: -
extension Raindrop.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.id, ascending: false)]
	}
}

// MARK: -
extension Predicate<Raindrop.Identified> {
	static func isInCollection(with id: Collection.ID, searchingFor query: String? = nil) -> Self {
		let predicate: Self = switch id {
		case .all: !.isInCollection(with: .trash)
		default: \.collection.id == id
		}

		let searchPredicate: Self? = query.flatMap { query in
			if let filterName = Filter.filterName(forQuery: query) {
				switch filterName {
				case .favorited:
					\.value.isFavorite == true
				case .broken:
					\.value.isBroken == true
				default:
					nil
				}
			} else if let itemType = Filter.itemType(forQuery: query) {
				\.value.itemType == itemType
			} else {
				nil
			}
		}

		return searchPredicate.map { predicate && $0 } ?? predicate
	}
}
