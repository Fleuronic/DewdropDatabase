// swift-tools-version:5.10
import PackageDescription

let package = Package(
	name: "DewdropDatabase",
	platforms: [
		.iOS(.v15),
		.macOS(.v12),
		.tvOS(.v13),
		.watchOS(.v6),
	],
	products: [
		.library(
			name: "DewdropDatabase",
			targets: ["DewdropDatabase"]
		),
	],
	dependencies: [
		.package(path: "../DewdropService"),
        .package(url: "https://github.com/Fleuronic/Catenoid", branch: "main")
	],
	targets: [
		.target(
			name: "DewdropDatabase",
			dependencies: [
				"Catenoid",
				"DewdropService"
			]
		)
	]
)
