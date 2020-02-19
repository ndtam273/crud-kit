import Vapor
import Fluent
import CrudAPI

final class Todo: Model, Content {
    static var schema = "todos"
    
    init() { }
    
    @ID(key: "id")
    var id: Int?
    
    init(id: Int? = nil) {
        self.id = id
    }
}

extension Todo: Crudable {
    static var path = "todos"
}

extension Todo {
    struct migration: Migration {
        var name = "TodoMigration"
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("todos")
                .field("id", .int, .identifier(auto: true))
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("todos").delete()
        }
    }
}

extension Todo {
    struct seeder: Migration {
        var name = "TodoSeeder"
        
        static let todos = [
            Todo(),
            Todo(),
            Todo(),
        ]
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            Self.todos.map {
                $0.save(on: database)
            }.flatten(on: database.eventLoop)
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            // Nothing to revert
            database.eventLoop.makeSucceededFuture(Void())
        }
    }
}