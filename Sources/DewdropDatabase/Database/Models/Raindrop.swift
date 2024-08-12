// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import enum Dewdrop.ItemType
import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct Dewdrop.Filter
import struct DewdropService.IdentifiedRaindrop
import struct PersistDB.Ordering
import protocol PersistDB.Model
import protocol Catenoid.Model

extension Raindrop.Identified: Schemata.Model {
	// MARK: Model
	public enum Path: String {
		case id
		case url
		case title
		case itemType
		case isFavorite = "favorite"
		case isBroken = "broken"
		case collection
	}

	public static var schema: Schema<Self> {
		let id = \Self.id * .id
		let url = \Self.value.url * .url
		let title = \Self.value.title * .title
		let itemType = \Self.value.itemType * .itemType
		let favorite = \Self.value.isFavorite * .isFavorite
		let broken = \Self.value.isBroken * .isBroken
		let collection = \Self.collection -?> .collection

		return .init(
			Self.init,
			id,
			url,
			title,
			itemType,
			favorite,
			broken,
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
	static func isInCollection(with id: Collection.ID, searchingFor search: String? = nil) -> Self {
		let predicate: Self = switch id {
		case .all: !.isInCollection(with: .trash)
		default: \.collection.id == id
		}

		let searchPredicate: Self? = if let search {
			if let name = Filter.ID.Name(rawValue: search) {
				switch name {
				case .favorited:
					\.value.isFavorite == true
				case .broken:
					\.value.isBroken == true
				default:
					nil
				}
			} else if let itemType = search.components(separatedBy: ":").last.flatMap(ItemType.init) {
				\.value.itemType == itemType
			} else {
				nil
			}
		} else {
			nil
		}

		return searchPredicate.map { predicate && $0 } ?? predicate
	}
}
