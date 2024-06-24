import SwiftUI

struct ImageLoaderView: View {
    @StateObject 
    private var imageLoader: ImageLoaderModel
    private var placeholder: UIImage

    init(url: URL?, placeholder: UIImage = UIImage(systemName: "photo")!) {
        _imageLoader = StateObject(wrappedValue: ImageLoaderModel(url: url))
        self.placeholder = placeholder
    }

    var body: some View {
        Image(uiImage: imageLoader.image ?? placeholder)
            .resizable()
    }
}
