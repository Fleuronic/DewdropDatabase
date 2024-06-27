// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Collection
import protocol DewdropService.RaindropSpec
import protocol Catena.Scoped
import protocol Catenoid.Database

extension Database: RaindropSpec {
	public typealias RaindropListFields = RaindropTitleFields

	public func listRaindrops(inCollectionWith id: Collection.ID = .all, searchingFor search: String? = nil/*, sortedBy sort: Raindrop.Sort? = nil*/, onPage page: Int? = nil, listing raindropsPerPage: Int? = nil) async -> Self.Result<[RaindropListFields]> {
		await fetch(RaindropListFields.self)
	}
}
