// Copyright © Fleuronic LLC. All rights reserved.

import protocol DewdropService.GroupSpec
import protocol Catena.Scoped

extension Database: GroupSpec {
	public func listGroups() async -> Results<GroupSpecifiedFields> {
		await fetch()
	}
}
