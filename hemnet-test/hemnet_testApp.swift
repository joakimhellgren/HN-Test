import SwiftUI

@main
struct hemnet_testApp: App {
    @StateObject private var propertySearchProvider = PropertySearchProvider()
    @StateObject private var propertyDetailProvider = PropertyDetailProvider()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(propertySearchProvider)
                .environmentObject(propertyDetailProvider)
        }
    }
}
