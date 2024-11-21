// Copyright © Fleuronic LLC. All rights reserved.

import protocol DewdropService.GroupSpec
import protocol Catena.Scoped

extension Database: GroupSpec {
	#if swift(<6.0)
	public typealias GroupListFields = GroupSpecifiedFields
	#endif

	public func listGroups() async -> Results<GroupSpecifiedFields> {
		await fetch()
	}
}
