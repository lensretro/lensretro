import Fluent


struct CreateFocalLength: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("focalLengths")
            .id()
            .field("mm", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("focalLengths").delete()
    }

}

struct CreateLensFocalLength: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("lens_focalLengths")
            .id()
            .field("lens_id", .uuid, .required, .references("lenses", "id"))
            .field("focalLength_id", .uuid, .required, .references("focalLengths", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("lens_focalLengths").delete()
    }
}
