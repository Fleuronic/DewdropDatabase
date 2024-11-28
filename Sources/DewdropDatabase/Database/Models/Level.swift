// Copyright © Fleuronic LLC. All rights reserved.

import struct Dewdrop.Collection
import struct Schemata.Value
import protocol Schemata.ModelValue

extension Collection.Access.Level: Schemata.ModelValue {
	public static var value: Schemata.Value<Int, Self> {
		Int.value.bimap(
			decode: { Self(rawValue: $0)! },
			encode: \.rawValue
		)
	}
}
