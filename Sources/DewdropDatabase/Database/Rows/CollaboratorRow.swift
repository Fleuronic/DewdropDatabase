// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import struct Dewdrop.User
import struct Dewdrop.Collaborator
import struct Schemata.Projection
import struct Foundation.URL
import struct Identity.Identifier
import protocol Catena.Representable
import protocol Catenoid.Row
import protocol Catenoid.Model
import protocol DewdropService.CollaboratorFields

public struct CollaboratorRow: CollaboratorFields {
	public let id: Collaborator.ID
	public let fullName: String
	public let email: String
	public let role: Collaborator.Role

	#if swift(<6.0)
	@Sendable init(
		id: Collaborator.ID,
		fullName: String,
		email: String,
		role: Collaborator.Role
	) {
		self.id = id
		self.fullName = fullName
		self.email = email
		self.role = role
	}
	#endif
}

// MARK: -
extension CollaboratorRow: Row {
	// MARK: Valued
	public typealias Value = Collaborator

	// MARK: Representable
	public var value: Value {
		.init(
			fullName: fullName,
			email: email,
			role: role
		)
	}

	// MARK: Row
	public init(collaborator: some Representable<Value, Collaborator.Identified>) {
		let value = collaborator.value

		self.init(
			id: collaborator.id,
			fullName: value.fullName,
			email: value.email,
			role: value.role
		)
	}

	// MARK: ModelProjection
	public static let projection = Projection<Collaborator.Identified, Self>(
		Self.init,
		\.id,
		\.value.fullName,
		\.value.email,
		\.value.role
	)
}

// MARK: -
extension CollaboratorRow: Catenoid.Model {
	// MARK: Model
	public var valueSet: ValueSet<Collaborator.Identified> {
		 [
			 \.value.fullName == fullName,
			 \.value.email == email,
			 \.value.role == role
		 ]
	 }
}
