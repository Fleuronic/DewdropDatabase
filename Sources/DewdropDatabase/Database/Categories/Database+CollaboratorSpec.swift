// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Collection
import struct Identity.Identifier
import protocol DewdropService.CollaboratorSpec
import protocol Catena.Scoped

extension Database: CollaboratorSpec {
	#if swift(<6.0)
	public typealias CollaboratorListFields = CollaboratorRow
	#endif

	public func listCollaborators(ofCollectionWith id: Collection.ID) async -> Results<CollaboratorRow> {
		await fetch() // TODO
	}
}
