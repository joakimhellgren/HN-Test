import XCTest
@testable import hemnet_test

final class PropertySearchProviderTests: XCTestCase {
    var sut: PropertySearchProvider!
    
    @MainActor
    override func setUp() {
        super.setUp()
        sut = .init(MockDownloader("MockProperties.json"))
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    @MainActor
    func testFetchResultShouldNotBeEmpty() async {
        await sut.fetch()
        XCTAssertFalse(sut.area.isEmpty && sut.properties.isEmpty)
    }
}

final class PropertyDetailProviderTests: XCTestCase {
    var sut: PropertyDetailProvider!
    
    @MainActor
    override func setUp() {
        super.setUp()
        sut = .init(MockDownloader("MockPropertyDetail.json"))
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    @MainActor
    func testFetchResultShouldNotBeNil() async {
        await sut.fetch()
        XCTAssertFalse(sut.item == nil)
    }
}


