// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Group
import protocol DewdropService.GroupSpec
import protocol Catena.Scoped
import protocol Catenoid.Database

extension Database: GroupSpec {
	public typealias GroupList = Self.Result<[GroupListFields]>
	public typealias GroupListFields = DewdropDatabase.GroupListFields

	public func listGroups() async -> GroupList {
		await fetch()
	}
}
