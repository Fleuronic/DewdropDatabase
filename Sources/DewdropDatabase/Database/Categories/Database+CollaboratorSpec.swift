// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Collaborator
import struct Dewdrop.Collection
import struct Identity.Identifier
import protocol DewdropService.CollaboratorSpec
import protocol Catena.Scoped

extension Database/*: CollaboratorSpec*/ {
	#if swift(<6.0)
	public typealias CollaboratorListFields = CollaboratorRow
	#endif

	public func listCollaborators(ofCollectionWith id: Collection.ID) async -> Results<CollaboratorRow> {
		await fetch() // TODO
	}

	public func shareCollection(with id: Collection.InvalidID, toCollaborateAs role: Collaborator.Role, sendingTo emails: [String]) async -> ImpossibleResult<Never> {
		// Cannot share collection using database
	}

	public func acceptInvitation(forCollectionWith id: Collection.InvalidID, usingToken token: String) async -> ImpossibleResult<Never> {
		// Cannot accept invitation for collection using database
	}
}
