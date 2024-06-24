import Foundation

fileprivate enum NetworkError: Error {
    case badURL
    case requestFailed
    case decodingFailed
}

protocol HTTPDataDownloader {
    func httpData<T: Decodable>(_ urlString: String) async throws -> T
}

extension URLSession: HTTPDataDownloader {
    func httpData<T: Decodable>(_ urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await self.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}

class MockDownloader: HTTPDataDownloader {
    let path: String
    init(_ path: String) {
        self.path = path
    }
    
    func httpData<T>(_ urlString: String) async throws -> T where T : Decodable {
        let data: Data
        
        guard let url = Bundle.main.url(forResource: path, withExtension: nil) else {
            throw NetworkError.badURL
        }
        
        do {
            try await Task.sleep(for: .seconds(.random(in: 1.0...3.0)))
            data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
