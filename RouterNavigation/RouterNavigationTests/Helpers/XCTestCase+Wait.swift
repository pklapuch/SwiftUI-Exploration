import XCTest

extension XCTestCase {
    func wait(timeInterval: TimeInterval) {
        let exp = expectation(description: "wait")
        DispatchQueue.global().asyncAfter(deadline: .now() + timeInterval, execute: {
            exp.fulfill()
        })
        wait(for: [exp], timeout: timeInterval + 0.1)
    }
}
