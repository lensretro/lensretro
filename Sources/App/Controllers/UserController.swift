import Fluent
import Vapor

struct UserController {

    func index(req: Request) throws -> EventLoopFuture<[User]> {

        return User.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<User> {

            try User.Create.validate(req)
            let create = try req.content.decode(User.Create.self)
            guard create.password == create.confirmPassword else {
                throw Abort(.badRequest, reason: "Passwords did not match")
            }
            let user = try User(
                name: create.name,
                email: create.email,
                passwordHash: Bcrypt.hash(create.password)
            )
            print(user)
            return user.save(on: req.db)
                .map { user }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {

        print(User.find(req.parameters.get("userID"), on: req.db) )
        return User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { .ok }
    }
}
