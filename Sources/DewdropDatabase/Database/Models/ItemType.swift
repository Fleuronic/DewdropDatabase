// Copyright © Fleuronic LLC. All rights reserved.

import enum Dewdrop.ItemType
import struct Schemata.Value
import protocol Schemata.ModelValue

extension ItemType: ModelValue {
	public static var value: Schemata.Value<String, Self> {
		String.value.bimap(
			decode: { Self(rawValue: $0)! },
			encode: \.rawValue
		)
	}
}
