// Copyright © Fleuronic LLC. All rights reserved.

import protocol DewdropService.GroupSpec
import protocol Catena.Scoped
import protocol Catenoid.Fields

extension Database: GroupSpec {
	public func listGroups() async -> Results<GroupListFields> {
		await fetch()
	}
}
