//
//  Resource.swift
//
//
//  Created by Andrew Barba on 7/31/24.
//

public class Resource {
    public let name: String

    public let type: String

    public var properties: [String: AnyEncodable]?

    public var dependsOn: [Resource]?

    public init(
        _ name: String,
        type: String,
        properties: [String: AnyEncodable]? = nil,
        dependsOn: [Resource]? = nil
    ) {
        self.name = name
        self.type = type
        self.properties = properties
        self.dependsOn = dependsOn
        Command.Store.current.resources.append(self)
    }

    internal func pulumiProjectResources() -> Pulumi.Project.Resources {
        return [
            slugify(name): .init(
                type: type,
                properties: properties,
                options: dependsOn.map {
                    .init(dependsOn: $0.map { $0.ref })
                }
            )
        ]
    }
}

extension Resource {

    public func keyPath(_ paths: String...) -> String {
        let root = slugify(name)
        let parts = [root] + paths
        return "${\(parts.joined(separator: "."))}"
    }

    public var ref: String {
        keyPath()
    }

    public var id: String {
        keyPath("id")
    }
}
