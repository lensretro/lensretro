import Fluent
import Vapor

struct MakerController {

    func index(req: Request) throws -> EventLoopFuture<[Maker]> {

        return Maker.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Maker> {

        let maker = try req.content.decode(Maker.self)
        return maker.save(on: req.db).map { maker }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {

        return Maker.find(req.parameters.get("makerID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { .ok }
    }
}
