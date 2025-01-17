// swift-tools-version:5.8
import PackageDescription

let package = Package(
	name: "DewdropDatabase",
	platforms: [
		.iOS(.v15),
		.macOS(.v12),
		.tvOS(.v15),
		.watchOS(.v8)
	],
	products: [
		.library(
			name: "DewdropDatabase",
			targets: ["DewdropDatabase"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/Fleuronic/DewdropService", branch: "main"),
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

for target in package.targets {
	target.swiftSettings = [
		.enableUpcomingFeature("StrictConcurrency")
	]
}
