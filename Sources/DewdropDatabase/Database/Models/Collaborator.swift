// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import struct Dewdrop.Collaborator
import struct DewdropService.IdentifiedUser
import protocol Catenoid.Model

extension Collaborator.Identified: Schemata.Model {
	// MARK: Model
	public enum Path: String {
		case id
		case fullName = "full_name"
		case email
		case role
	}

	public static var schema: Schema<Self> {
		let id = \Self.id * .id
		let fullName = \Self.value.fullName * .fullName
		let email = \Self.value.email * .email
		let role = \Self.value.role * .role

		return .init(
			Self.init,
			id,
			fullName,
			email,
			role
		)
	}

	public static let schemaName = "collaborators"
}

// MARK: -
extension Collaborator.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.id)]
	}
}
