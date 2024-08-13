// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Group
import protocol DewdropService.GroupSpec
import protocol Catena.Scoped
import protocol Catenoid.Database
import protocol Catenoid.Fields

extension Database: GroupSpec {
	public func listGroups() async -> Self.Result<[GroupListFields]> {
		await fetch()
	}
}
