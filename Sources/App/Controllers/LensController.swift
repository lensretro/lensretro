import Fluent
import Vapor

struct LensController {

    func index(req: Request) throws -> EventLoopFuture<[Lens]> {

        return Lens.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Lens> {

        let lens = try req.content.decode(Lens.self)
        return lens.save(on: req.db).map { lens }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {

        return Lens.find(req.parameters.get("lensID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { .ok }
    }
}
