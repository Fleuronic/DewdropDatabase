import Schemata

import struct Dewdrop.Collection
import struct Dewdrop.Highlight
import struct DewdropService.IdentifiedCollection
import struct DewdropService.IdentifiedHighlight

extension Array: Schemata.AnyModel where Element: Model {
	public static var anySchema: Schemata.AnySchema {
		.init(schema)
	}
}

extension Array: Schemata.Model where Element: Model {
	public static var schema: Schema<Self> {
		if let collections = self as? [Collection.Identified].Type {
			return collections.schema as! Schema<Self>
		}

		fatalError()
	}
}
