import Foundation

protocol Provider {
    var service: any ServiceProtocol { get }
    var error: ProviderError? { get async }
    func fetch() async
}

enum ProviderError: Error {
    case missingData
    case networkError
    case unexpectedError(error: Error)
}

extension ProviderError: LocalizedError {
    var errorDescription: String? {
        return switch self {
        case .missingData:
            NSLocalizedString("Service provider data missing.", comment: "")
        case .networkError:
            NSLocalizedString("Error fetching service provider data over the network.", comment: "")
        case .unexpectedError(let error):
            NSLocalizedString("Received unexpected error in a service provider. \(error.localizedDescription)", comment: "")
        }
    }
}
