import Vapor
import Fluent

public struct CrudChildrenController<T: Model & Crudable, ParentT: Model> where T.IDValue: LosslessStringConvertible, ParentT.IDValue: LosslessStringConvertible {
    var idComponentKey: String
    var parentIdComponentKey: String
    
    var children: KeyPath<ParentT, ChildrenProperty<ParentT, T>>
}

extension CrudChildrenController {
    internal func indexAll(req: Request) -> EventLoopFuture<[T.Public]> {
        ParentT.fetch(from: parentIdComponentKey, on: req).flatMap { parent in
            parent[keyPath: self.children].query(on: req.db).all().public()
        }
    }
    
//    internal func index(req: Request) -> EventLoopFuture<T.Public> {
//        T.fetch(from: idComponentKey, on: req).public()
//    }
//
//    internal func create(req: Request) throws -> EventLoopFuture<T.Public> {
//        try T.Create.validate(on: req)
//        let data = try req.content.decode(T.Create.self)
//        let model = try T.init(from: data)
//        return model.save(on: req.db).map { model }.public()
//    }
//
//    internal func replace(req: Request) throws -> EventLoopFuture<T.Public> {
//        try T.Replace.validate(on: req)
//        let data = try req.content.decode(T.Replace.self)
//        return T.fetch(from: idComponentKey, on: req).flatMap { oldModel in
//            do {
//                let model = try oldModel.replace(with: data)
//                model.id = oldModel.id
//                model._$id.exists = oldModel._$id.exists
//                return model.update(on: req.db).map { model }.public()
//            } catch {
//                return req.eventLoop.makeFailedFuture(error)
//            }
//        }
//    }
//
//    internal func delete(req: Request) -> EventLoopFuture<HTTPStatus> {
//        T.fetch(from: idComponentKey, on: req)
//            .flatMap { $0.delete(on: req.db) }.map { .ok }
//    }
}

extension CrudChildrenController where T: Patchable {
//    internal func patch(req: Request) throws -> EventLoopFuture<T.Public> {
//        try T.Patch.validate(on: req)
//        let data = try req.content.decode(T.Patch.self)
//        return T.fetch(from: idComponentKey, on: req).flatMap { model in
//            do {
//                try model.patch(with: data)
//                return model.update(on: req.db).map { model }.public()
//            } catch {
//                return req.eventLoop.makeFailedFuture(error)
//            }
//        }
//    }
}
