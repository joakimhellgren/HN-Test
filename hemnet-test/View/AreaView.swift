import SwiftUI

struct AreaView: View {
    let item: AreaModel
        
    var body: some View {
        VStack(alignment: .leading) {
            ImageLoaderView(url: URL(string: item.image))
                .scaledToFill()
                .frame(maxHeight: 180)
                .clipped()
            VStack(alignment: .leading) {
                Text(item.area).bold()
                HStack {
                    Text("Rating:")
                    Text(item.ratingFormatted)
                }
                HStack(alignment: .top, spacing: 4) {
                    Text("Average price:")
                    Text(item.averagePrice,
                         format: .currency(code: "SEK"))
                    Text("/ m\u{00B2}")
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    AreaView(item: .preview)
}
#endif
