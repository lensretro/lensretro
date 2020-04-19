import Fluent
import Vapor

final class Maker: Model, Content {

    static let schema = "makers"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Children(for: \.$maker)
    var lenses: [Lens]

    
    init() { }

    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
