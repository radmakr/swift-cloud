import Foundation

extension AWS {
    public struct Role: ResourceProvider {
        public let resource: Resource

        public init(
            _ name: String,
            service: String,
            options: Resource.Options? = nil
        ) {
            resource = Resource(
                name: name,
                type: "aws:iam:Role",
                properties: [
                    "assumeRolePolicy": Resource.JSON([
                        "Version": "2012-10-17",
                        "Statement": [
                            [
                                "Effect": "Allow",
                                "Principal": ["Service": service],
                                "Action": "sts:AssumeRole",
                            ]
                        ],
                    ])
                ],
                options: options
            )
        }
    }
}