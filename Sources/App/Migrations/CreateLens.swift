import Fluent

struct CreateLens: Migration {

    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        database.schema("lenses")
            .id()
            .field("name", .string, .required)
            .field("maker_id", .uuid, .references("makers", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        
        return database.schema("lenses").delete()
    }
}
