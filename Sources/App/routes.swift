import Fluent
import Vapor


func routes(_ app: Application) throws {
    
    defaultRoutes(app)
     
    userRoutes(app)
    
    lensRoutes(app)
    makerRoutes(app)
    focalLengthRoutes(app)
}

func defaultRoutes(_ app: Application) {
    
    app.get { req in
         return "It works!"
     }
     
     app.get("hello") { req in
         return "Hello, world!"
     }
}

// MARK: - User Routes -

func userRoutes(_ app: Application) {
    
    let userController = UserController()
    app.get("users", use: userController.index)
    app.post("users", use: userController.create)
    app.delete("users", ":userID", use: userController.delete)
    
    let passwordProtected = app.grouped(User.authenticator().middleware())
    passwordProtected.post("login") { req -> EventLoopFuture<UserToken> in
        let user = try req.auth.require(User.self)
        let token = try user.generateToken()
        return token.save(on: req.db)
            .map { token }
    }
    
    let tokenProtected = app.grouped(UserToken.authenticator().middleware())
    tokenProtected.get("mRoe") { req -> User in
        try req.auth.require(User.self)
    }
}

// MARK: - Other Routes -

func makerRoutes(_ app: Application) {

    let makerController = MakerController()
     app.get("makers", use: makerController.index)
     app.post("makers", use: makerController.create)
     app.on(.DELETE, "makers", ":lensID", use: makerController.delete)
     app.get("makers") { req in
         Maker.query(on: req.db).with(\.$lenses).all()
     }
}

func lensRoutes(_ app: Application) {

    let lensController = LensController()
     app.get("lenses", use: lensController.index)
     app.post("lenses", use: lensController.create)
     app.on(.DELETE, "lenses", ":lensID", use: lensController.delete)
}

func focalLengthRoutes(_ app: Application) {

    app.post("lens", ":lensID", "focalLength", ":focalLengthID") { req -> EventLoopFuture<HTTPStatus> in
        let lens = Lens.find(req.parameters.get("lensID"), on: req.db)
            .unwrap(or: Abort(.notFound))
        let focalLength = FocalLength.find(req.parameters.get("focalLengthID"), on: req.db)
            .unwrap(or: Abort(.notFound))
        return lens.and(focalLength).flatMap { (lens, focalLength) in
            lens.$focalLengths.attach(focalLength, on: req.db)
        }.transform(to: .ok)
    }
}
