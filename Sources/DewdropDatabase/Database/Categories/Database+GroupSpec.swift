// Copyright © Fleuronic LLC. All rights reserved.

public import protocol DewdropService.GroupSpec
public import protocol Catena.Scoped
public import protocol Catenoid.Fields

extension Database: GroupSpec {
	public func listGroups() async -> Self.Result<[GroupListFields]> {
		await fetch()
	}
}
