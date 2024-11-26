// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import struct Dewdrop.User
import struct DewdropService.IdentifiedUser
import protocol Catenoid.Model

extension User.Identified: Schemata.Model {
	// MARK: Model
	public enum Path: String {
		case id
		case fullName = "full_name"
		case email
		case avatarURL = "avatar_url"
		case hasProSubscription = "has_pro_subscription"
	}

	public static var schema: Schema<Self> {
		let id = \Self.id * .id
		let fullName = \Self.value.fullName * .fullName
		let email = \Self.value.email * .email
		let avatarURL = \Self.value.avatarURL * .avatarURL
		let hasProSubscription = \Self.value.hasProSubscription * .hasProSubscription

		return .init(
			Self.init,
			id,
			fullName,
			email,
			avatarURL,
			hasProSubscription
		)
	}

	public static let schemaName = "users"
}

// MARK: -
extension User.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.id)]
	}
}
