// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import enum Dewdrop.Password
import struct Dewdrop.User
import struct Dewdrop.Network
import protocol DewdropService.UserSpec
import protocol Catena.Scoped

extension Database: UserSpec {
	public func fetchUser(with id: User.ID) async -> SingleResult<UserPublicResultFields?> {
		await fetch(where: \.id == id).map(\.first)
	}

	public func fetchAuthenticatedUser() async -> SingleResult<UserAuthenticatedResultFields?> {
		await fetch().map(\.first)
	}

	public func connectSocialNetworkAccount(from provider: Network.Offline) async -> NoResult {
		// Provider is offline; cannot connect using database
	}

	public func disconnectSocialNetworkAccount(from provider: Network.Offline) async -> NoResult {
		// Provider is offline; cannot disconnect using database
	}

	public func updateAuthenticatedUser(
		fullName: String?,
		email: String?,
		password: Password?
//		config: User.Config?
//		groups: [Group]?
	) async -> SingleResult<UserAuthenticatedResultFields> {
		fatalError()
	}
}
