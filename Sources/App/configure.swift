import Vapor
import Fluent
import FluentSQLiteDriver
import FluentPostgresDriver


// Called before your application initializes.
public func configure(_ app: Application) throws {
    // Serves files from `Public/` directory
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Configure Postgres database
    app.databases.use(.postgres(
        hostname: "localhost",
        username: "alex",
        password: "chaos123",
        database: "lensretrodb"
    ), as: .psql)
    
    try app.http.server.configuration.tlsConfiguration = .forServer(
//        certificateChain: [
//            .certificate(.init(
//                file: "server.cert",
//                format: .pem
//            ))
//        ],
//        privateKey: .file("server.key")
   )

    // Configure migrations
    app.migrations.add(User.Migration())
    app.migrations.add(UserToken.Migration())
    app.migrations.add(CreateMaker())
    app.migrations.add(CreateLens())
    app.migrations.add(CreateFocalLength())
    app.migrations.add(CreateLensFocalLength())

    try routes(app)
}
