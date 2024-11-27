// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Highlight
import struct Schemata.Value
import protocol Schemata.ModelValue

extension Highlight.Color: Schemata.ModelValue {
	public static var value: Schemata.Value<String, Self> {
		String.value.bimap(
			decode: { Self(rawValue: $0)! },
			encode: \.rawValue
		)
	}
}
