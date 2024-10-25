// Copyright © Fleuronic LLC. All rights reserved.

public import enum Dewdrop.ItemType
public import struct Schemata.Value
public import protocol Schemata.ModelValue

extension ItemType: Schemata.ModelValue {
	public static var value: Schemata.Value<String, Self> {
		String.value.bimap(
			decode: { Self(rawValue: $0)! },
			encode: \.rawValue
		)
	}
}
