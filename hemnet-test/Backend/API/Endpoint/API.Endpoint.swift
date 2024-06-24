extension API {
    enum Endpoint {}
}

extension API.Endpoint {
    enum EndpointError: Error {
        case badPath
        case conversionFailure
    }
}
