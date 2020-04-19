import Fluent
import Vapor

final class FocalLength: Model, Content {

    static let schema: String = "focalLengths"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "mm")
    var mm: String
    
    @Siblings(through: LensFocalLength.self, from: \.$focalLength, to: \.$lens)
    var lenses: [Lens]

    // Creates a new, empty Tag.
    init() {}

    // Creates a new Tag with all properties set.
    init(id: UUID? = nil, mm: String) {
        self.id = id
        self.mm = mm
    }
    
}
