// Copyright © Fleuronic LLC. All rights reserved.

public import struct Dewdrop.Collection
public import protocol DewdropService.RaindropSpec
public import protocol Catena.Scoped
public import protocol Catenoid.Fields

extension Database: RaindropSpec {
	public func listRaindrops(inCollectionWith id: Collection.ID = .all, searchingFor query: String? = nil/*, sortedBy sort: Raindrop.Sort? = nil*/, onPage page: Int? = nil, listing raindropsPerPage: Int? = nil) async -> Self.Result<[RaindropListFields]> {
		await fetch(where: .isInCollection(with: id, searchingFor: query))
	}
}
