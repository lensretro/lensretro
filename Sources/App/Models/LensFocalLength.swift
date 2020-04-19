import Fluent
import Vapor


final class LensFocalLength: Model {
    // Name of the table or collection.
    static let schema: String = "lens_focalLength"

    // Unique identifier for this pivot.
    @ID(key: .id)
    var id: UUID?

    // Reference to the Tag this pivot relates.
    @Parent(key: "focalLength_id")
    var focalLength: FocalLength

    // Reference to the Star this pivot relates.
    @Parent(key: "lens_id")
    var lens: Lens

    // Creates a new, empty pivot.
    init() {}

    // Creates a new pivot with all properties set.
    init(focalLengthID: UUID, lensID: UUID) {
        self.$lens.id = focalLengthID
        self.$focalLength.id = lensID
    }

}
