import Fluent

struct CreateMaker: Migration {

    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        database.schema("makers")
            .id()
            .field("name", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        
        return database.schema("makers").delete()
    }
}
