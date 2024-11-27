// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.Collection

extension Array: Schemata.AnyModel where Element: Model {
	public static var anySchema: Schemata.AnySchema {
		.init(schema)
	}
}

extension Array: Schemata.Model where Element: Model {
	public static var schema: Schema<Self> {
		let collections = self as! [Collection.Identified].Type
		return collections.schema as! Schema<Self>
	}
}
