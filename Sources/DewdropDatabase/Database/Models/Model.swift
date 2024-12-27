// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Dewdrop.Media

extension Array: Schemata.AnyModel where Element: Model {
	public static var anySchema: Schemata.AnySchema {
		.init(schema)
	}
}

extension Array: Schemata.Model where Element: Model {
	public static var schema: Schema<Self> {
		(self as! [Media.Identified].Type).schema as! Schema<Self>
	}
}
