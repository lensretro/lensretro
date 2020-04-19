import Fluent
import Vapor

struct FocalLengthController {

//    func create(req: Request) throws -> EventLoopFuture<Lens> {
//        
//        let lens = Lens.find(req.parameters.get("lensID"), on: req.db)
//            .unwrap(or: Abort(.notFound))
//        let focalLength = FocalLength.find(req.parameters.get("focalLengthID"), on: req.db)
//            .unwrap(or: Abort(.notFound))
//        return lens.and(focalLength).flatMap { (lens, focalLength) in
//            lens.$focalLengths.attach(focalLength, on: req.db)
//        }//.transform(to: .ok)
//    }
        
//    func create(req: Request) throws -> EventLoopFuture<Lens> {
//
//        let lens = try req.content.decode(Lens.self)
//        return lens.save(on: req.db).map { lens }
//    }
}
