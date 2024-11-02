// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Collection
import protocol DewdropService.RaindropSpec
import protocol Catenoid.Fields
import protocol Catena.Scoped

extension Database: RaindropSpec {
	public func listRaindrops(inCollectionWith id: Collection.ID = .all, searchingFor query: String? = nil/*, sortedBy sort: Raindrop.Sort? = nil*/, onPage page: Int? = nil, listing raindropsPerPage: Int? = nil) async -> Results<RaindropListFields> {
		await fetch(where: .isInCollection(with: id, searchingFor: query))
	}
}
