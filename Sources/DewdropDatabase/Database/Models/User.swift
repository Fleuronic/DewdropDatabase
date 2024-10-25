// Copyright © Fleuronic LLC. All rights reserved.

public import Schemata
public import PersistDB

public import struct Dewdrop.User
public import struct DewdropService.IdentifiedUser
public import protocol Catenoid.Model

extension User.Identified: Schemata.Model {
	// MARK: Model
	public enum Path: String {
		case id
		case fullName = "full_name"
		case hasProSubscription = "has_pro_subscription"
	}

	public static let schema = Schema(
		Self.init,
		\.id * .id,
		\.value.fullName * .fullName,
		\.value.hasProSubscription * .hasProSubscription
	)

	public static let schemaName = "users"
}

// MARK: -
extension User.Identified: PersistDB.Model {
	// MARK: Model
	public static var defaultOrder: [Ordering<Self>] {
		[.init(\.id, ascending: true)]
	}
}
