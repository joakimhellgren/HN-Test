import SwiftUI

struct PropertyDetailView: View {
    @EnvironmentObject
    var provider: PropertyDetailProvider
    
    @StateObject
    var viewModel: PropertyDetailViewModel
    
    init(_ item: PropertyModel) {
        self._viewModel = StateObject(wrappedValue: PropertyDetailViewModel(item: item))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ImageLoaderView(url: URL(string: viewModel.item.image))
                    .scaledToFit()
                    .clipped()
                VStack(alignment: .leading) {
                    Text(viewModel.item.streetAddress)
                        .font(.title)
                    HStack(spacing: 4) {
                        Text("\(viewModel.item.area), \(viewModel.item.municipality)")
                    }
                    .fontWeight(.light)
                    Text(viewModel.item.askingPrice, format: .currency(code: "SEK"))
                        .font(.title3)
                        .bold()
                }
                if let description = viewModel.description {
                    Text(description)
                        .multilineTextAlignment(.leading)
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                }
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Living area:").bold()
                        Text("\(viewModel.item.livingArea) / m\u{00B2}")
                    }
                    HStack {
                        Text("Number of rooms:").bold()
                        Text("\(viewModel.item.numberOfRooms)")
                    }
                    HStack {
                        Text("Patio:").bold()
                        Text(viewModel.patio ?? "")
                    }
                    HStack {
                        Text("Days since publish:").bold()
                        Text("\(viewModel.item.daysSincePublish)")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal)
        .task(provider.fetch)
        .onReceive(provider.$item, perform: viewModel.update)
    }
}

#if DEBUG
#Preview {
    PropertyDetailView(.preview)
        .environmentObject(PropertyDetailProvider(MockDownloader("MockPropertyDetail.json")))
}
#endif
