import SwiftUI

fileprivate extension PropertyModel {
   var isHighlighted: Bool { type == "HighlightedProperty" }
}

struct PropertyView: View {
   let item: PropertyModel
   
   var body: some View {
       VStack(alignment: .leading, spacing: 8) {
           NavigationLink(value: item) {
               ImageLoaderView(url: URL(string: item.image))
                   .scaledToFill()
                   .frame(maxHeight: 180)
                   .clipped()
                   .border(Color.orange, width: item.isHighlighted ? 2 : 0)
           }
           .disabled(!item.isHighlighted)
           .padding(.bottom)
           Text(item.streetAddress)
               .font(.title3)
               .bold()
           Text("\(item.area), \(item.municipality)")
               .fontWeight(.light)
           HStack(spacing: 4) {
               Text(item.askingPrice, format: .currency(code: "SEK"))
                   .frame(maxWidth: .infinity, alignment: .leading)
               Text("\(item.livingArea) / m\u{00B2}")
                   .frame(maxWidth: .infinity, alignment: .center)
               Text("\(item.numberOfRooms) rooms")
                   .frame(maxWidth: .infinity, alignment: .trailing)
           }
           .bold()
           .lineLimit(1)
           .minimumScaleFactor(0.5)
       }
   }
}

#if DEBUG
#Preview {
    PropertyView(item: .preview)
}
#endif
