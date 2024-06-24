import SwiftUI
import Combine

final class ImageLoaderModel: ObservableObject {
    @Published var image: UIImage?
    private var url: URL?
    private var cacheDuration: TimeInterval = 24 * 60 * 60 // 24 hours
    private var cancellable: AnyCancellable?
    
    init(url: URL?) {
        self.url = url
        loadImage()
    }
    
    private var cacheDirectory: URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
    
    private func cacheFileURL(for url: URL) -> URL {
        cacheDirectory.appendingPathComponent(url.lastPathComponent)
    }
    
    private func isCacheValid(for url: URL) -> Bool {
        let cacheURL = cacheFileURL(for: url)
        guard let attributes = try? FileManager.default.attributesOfItem(atPath: cacheURL.path),
              let modificationDate = attributes[.modificationDate] as? Date else {
            return false
        }
        return Date().timeIntervalSince(modificationDate) < cacheDuration
    }
    
    func loadImage() {
        guard let url = url else { return }
        let cacheURL = cacheFileURL(for: url)
        
        if isCacheValid(for: url), let cachedImage = UIImage(contentsOfFile: cacheURL.path) {
            self.image = cachedImage
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                guard let self = self, let image = image else { return }
                self.image = image
                self.saveImageToDisk(image: image, for: url)
            }
    }
    
    private func saveImageToDisk(image: UIImage, for url: URL) {
        guard let data = image.pngData() else { return }
        let cacheURL = cacheFileURL(for: url)
        try? data.write(to: cacheURL)
    }
    
    deinit {
        cancellable?.cancel()
    }
}

