//
//  Variable.swift
//
//
//  Created by Andrew Barba on 7/31/24.
//

public class Variable {
    public let name: String

    public var definition: AnyEncodable

    public init(
        _ name: String,
        definition: AnyEncodable
    ) {
        self.name = name
        self.definition = definition
        Command.Store.current.variables.append(self)
    }

    internal func pulumiProjectVariables() -> Pulumi.Project.Variables {
        return [
            slugify(name): definition
        ]
    }
}

extension Variable {

    public func keyPath(_ paths: String...) -> String {
        let root = slugify(name)
        let parts = [root] + paths
        return "${\(parts.joined(separator: "."))}"
    }

    public var value: String {
        keyPath()
    }
}
