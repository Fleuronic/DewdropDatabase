// swift-tools-version:6.0
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
		.package(path: "../../Submodules/DewdropService"),
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
	],
	swiftLanguageModes: [.v6]
)
	
for target in package.targets {
	target.swiftSettings = [
		.enableUpcomingFeature("ExistentialAny")
	]
}
