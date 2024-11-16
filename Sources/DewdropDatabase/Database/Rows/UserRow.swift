// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import struct Dewdrop.User
import struct Foundation.URL
import protocol Catenoid.Fields
import protocol Catenoid.Model
import protocol DewdropService.UserAuthenticatedFields

struct UserRow: UserAuthenticatedFields {
	let id: User.ID
	let fullName: String
	let email: String?
	let avatarURL: URL?
	let hasProSubscription: Bool?
}

// MARK
extension UserRow: Fields {
	// MARK: ModelProjection
	static let projection = Projection<Self.Model, Self>(
		Self.init,
		\.id,
		\.value.fullName,
		\.value.email,
		\.value.avatarURL,
		\.value.hasProSubscription
	)
}

// MARK: -
extension UserRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<User.Identified> {
		[
			\.value.fullName == fullName,
			\.value.email == email,
			\.value.avatarURL == avatarURL,
			\.value.hasProSubscription == hasProSubscription
		]
	}
}
