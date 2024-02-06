import XCTest

final class SimpleStateTests: XCTestCase {

    struct User {
        var id: Int
        var isAdmin: Bool
        var name: String
    }


    func test() throws {

        var user = User(id: 42, isAdmin: true, name: "Joe")

        user[keyPath: \.id] = 8

        let counterReducer: Reducer<Int, Void> = { count, _ in
            count += 1
        }

        let userIdReducer = pullback(reducer: counterReducer, value: \User.id)
        userIdReducer(&user, ())
        userIdReducer(&user, ())
        userIdReducer(&user, ())

        print(user.id)


    }

    typealias Reducer<Value, Action> = (inout Value, Action) -> ()

    func pullback<GlobalValue, LocalValue, Action>(
        reducer: @escaping Reducer<LocalValue, Action>,
        value: WritableKeyPath<GlobalValue, LocalValue>
    ) -> Reducer<GlobalValue, Action> {
        return { globalValue, action in
            reducer(&globalValue[keyPath: value], action)
        }
    }
}
