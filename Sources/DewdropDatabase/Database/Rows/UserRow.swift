// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.User
import struct Foundation.URL
import protocol Catena.Representable
import protocol Catenoid.Row
import protocol Catenoid.RowIdentifying
import protocol DewdropService.UserAuthenticatedFields

public struct UserRow: UserAuthenticatedFields {
	public let id: User.ID
	public let fullName: String
	public let email: String?
	public let avatarURL: URL?
	public let hasProSubscription: Bool?
}

// MARK: -
extension UserRow: Row {
	// MARK: Valued
	public typealias Value = User

	// MARK: Representable
	public var value: Value {
		.init(
			fullName: fullName,
			email: email,
			avatarURL: avatarURL,
			hasProSubscription: hasProSubscription
		)
	}

	// MARK: ModelProjection
	public static let projection = Projection<Self.Model, Self>(
		Self.init,
		\.id,
		\.value.fullName,
		\.value.email,
		\.value.avatarURL,
		\.value.hasProSubscription
	)
}

// MARK: -
extension User: Catenoid.RowIdentifying {
	public static func identified(from row: UserRow?) -> Identified? {
		row.map(Identified.init)
	}
}
