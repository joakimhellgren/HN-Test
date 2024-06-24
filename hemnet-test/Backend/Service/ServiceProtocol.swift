protocol ServiceProtocol {
    associatedtype Result
    func fetch() async throws -> Result
}
