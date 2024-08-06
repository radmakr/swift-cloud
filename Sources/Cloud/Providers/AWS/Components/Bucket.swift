extension aws {
    public struct Bucket: Component {
        internal let bucket: Resource
        internal let ownershipControls: Resource
        internal let publicAccessBlock: Resource

        public var name: String {
            bucket.id
        }

        public var hostname: String {
            bucket.keyPath("bucketRegionalDomainName")
        }

        public init(
            _ name: String,
            options: Resource.Options? = nil
        ) {
            bucket = Resource(
                name,
                type: "aws:s3:Bucket",
                options: options
            )

            ownershipControls = Resource(
                "\(name)-ownershipControls",
                type: "aws:s3:BucketOwnershipControls",
                properties: [
                    "bucket": "\(bucket.ref)",
                    "rule": [
                        "objectOwnership": "ObjectWriter"
                    ],
                ],
                options: options
            )

            publicAccessBlock = Resource(
                "\(name)-publicAccessBlock",
                type: "aws:s3:BucketPublicAccessBlock",
                properties: [
                    "bucket": "\(bucket.ref)",
                    "blockPublicAcls": false,
                ],
                options: options
            )
        }
    }
}
