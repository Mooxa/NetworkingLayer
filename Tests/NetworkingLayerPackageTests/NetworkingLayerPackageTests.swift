    import XCTest
    import Combine
    @testable import NetworkingLayerPackage

    
    struct AddTodo: Request {
         typealias ReturnType = [Todo]
         var path: String = "/todos"
         var method: HTTPMethod = .post
        var body: [String: Any]
        init(body: [String: Any]) {
            self.body = body
        }
    }
    let todo: [String: Any] = ["title": "Test Todo", "completed": true]

    final class NetworkingLayerPackageTests: XCTestCase {
        
        private var cancellables = [AnyCancellable]()
        let dispatcher = NetworkDispatcher()
        let apiClient = APIClient(baseURL: "https://jsonplaceholder.typicode.com")
        func testGetTodos() {
            apiClient.dispatch(FindTodos())
                .sink(receiveCompletion: { _ in },
                      receiveValue: { value in
                        print(value)
                    })
                .store(in: &cancellables)
        }
  
        func testAddTodos() {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct
            // results.
                apiClient.dispatch(AddTodo(body: todo))
                    .sink(receiveCompletion: { result in
                        // Do something after adding...
                        },
                        receiveValue: { _ in })
                    .store(in: &cancellables)
        }
        
    }
