// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.User
import struct Schemata.Projection
import struct Foundation.URL
import protocol Catena.Representable
import protocol Catenoid.Row
import protocol Catenoid.Model
import protocol DewdropService.UserAuthenticatedFields

public struct UserRow: UserAuthenticatedFields {
	public let id: User.ID
	public let fullName: String
	public let email: String?
	public let avatarURL: URL?
	public let hasProSubscription: Bool?

	#if swift(<6.0)
	@Sendable init(
		id: User.ID,
		fullName: String,
		email: String?,
		avatarURL: URL?,
		hasProSubscription: Bool?
	) {
		self.id = id
		self.fullName = fullName
		self.email = email
		self.avatarURL = avatarURL
		self.hasProSubscription = hasProSubscription
	}
	#endif
}

// MARK: -
public extension UserRow {
	init(user: some Representable<Value, IdentifiedValue>) {
		let value = user.value
		self.init(
			id: user.id,
			fullName: value.fullName,
			email: value.email,
			avatarURL: value.avatarURL,
			hasProSubscription: value.hasProSubscription
		)
	}
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
	public static let projection = Projection<Model, Self>(
		Self.init,
		\.id,
		\.value.fullName,
		\.value.email,
		\.value.avatarURL,
		\.value.hasProSubscription
	)
}

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
