// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Collection
import protocol DewdropService.RaindropSpec
import protocol Catena.Scoped
import protocol Catenoid.Database

extension Database: RaindropSpec {
	public typealias RaindropListFields = DewdropDatabase.RaindropListFields
	public typealias RaindropList = Self.Result<[RaindropListFields]>

	public func listRaindrops(inCollectionWith id: Collection.ID = .all, searchingFor search: String? = nil/*, sortedBy sort: Raindrop.Sort? = nil*/, onPage page: Int? = nil, listing raindropsPerPage: Int? = nil) async -> RaindropList {
		await fetch(where: id.containsRaindrop)
	}
}
