import Fluent
import Vapor

final class Lens: Model, Content {
    static let schema = "lenses"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    @Parent(key: "maker_id")
    var maker: Maker

    @Siblings(through: LensFocalLength.self, from: \.$lens, to: \.$focalLength)
    var focalLengths: [FocalLength]

    init() { }

    init(id: UUID? = nil, name: String, makerID: UUID) {
        self.id = id
        self.name = name
        self.$maker.id = makerID
    }
}
