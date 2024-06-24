import SwiftUI

struct ContentView: View {
    @EnvironmentObject 
    var provider: PropertySearchProvider
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 25) {
                    ForEach(provider.area, content: AreaView.init)
                    Divider()
                    ForEach(provider.properties, content: PropertyView.init)
                }
                .padding(.horizontal)
                .blur(radius: provider.isLoading ? 8 : 0)
            }
            .overlay(progressOverlay)
            .navigationTitle("Area")
            .refreshable(action: provider.fetch)
            .navigationDestination(for: PropertyModel.self, destination: PropertyDetailView.init)
        }
        .alert(isPresented: .constant(provider.error != nil), error: provider.error) {}
        .task(provider.fetch)
    }
    
    @ViewBuilder
    private var progressOverlay: some View {
        if (provider.area.isEmpty && provider.properties.isEmpty) { ProgressView() }
    }
}

#if DEBUG
#Preview {
    ContentView()
        .environmentObject(PropertySearchProvider(MockDownloader("MockProperties.json")))
        .environmentObject(PropertyDetailProvider(MockDownloader("MockPropertyDetail.json")))
}
#endif
