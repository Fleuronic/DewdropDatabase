// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Raindrop
import struct Dewdrop.Collection
import struct PersistDB.Predicate
import protocol DewdropService.RaindropSpec
import protocol Catena.Scoped
import protocol Catenoid.Database
import protocol Catenoid.Fields

extension Database: RaindropSpec where RaindropListFields: Fields {
	public func listRaindrops(inCollectionWith id: Collection.ID = .all, searchingFor search: String? = nil/*, sortedBy sort: Raindrop.Sort? = nil*/, onPage page: Int? = nil, listing raindropsPerPage: Int? = nil) async -> Self.Result<[RaindropListFields]> {
		await fetch(where: .isInCollection(with: id, searchingFor: search))
	}
}
