import PackageDescription

let package = Package(
  name: "Swiftg8",
  dependencies: [
   .Package(url: "https://github.com/frontg8/SCFrontg8.git", majorVersion: 1)
  ]
)

package.targets = [
  Target(name: "Swiftg8"),
  Target(name: "Swiftg8Demo", dependencies: ["Swiftg8"]),
]
