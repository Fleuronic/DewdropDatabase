// Copyright © Fleuronic LLC. All rights reserved.

import enum Dewdrop.Password
import struct Dewdrop.User
import struct Dewdrop.Network
import protocol DewdropService.UserSpec
import protocol Catena.Scoped

extension Database {
	#if swift(<6.0)
	public typealias PublicUserFetchFields = UserPublicSpecifiedFields
	public typealias AuthenticatedUserFetchFields = UserAuthenticatedSpecifiedFields
	#endif

	public func fetchUser(with id: User.ID) async -> SingleResult<UserPublicSpecifiedFields?> {
		await fetch(with: id).map(\.first)
	}

	public func fetchAuthenticatedUser() async -> SingleResult<UserAuthenticatedSpecifiedFields?> {
		await fetch().map(\.first)
	}

	public func connectSocialNetworkAccount(from provider: Network.Offline) async -> EmptyResult {
		// Provider is offline; cannot connect using database
	}

	public func disconnectSocialNetworkAccount(from provider: Network.Offline) async -> EmptyResult {
		// Provider is offline; cannot disconnect using database
	}
}
