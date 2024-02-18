import SwiftUI

struct Market: View {
    @State private var blocks = Array(1...8).map { "Product \($0)" } // Initial blocks
    @State private var additionalBlocksLoaded = 0 // Tracks the number of additional blocks loaded

    var body: some View {
        TabView {
            // Market Tab
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(blocks, id: \.self) { block in
                            NavigationLink(destination: ProductDetailView(product: block)) {
                                VStack {
                                    Image(systemName: "photo") // Placeholder image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                        .background(Color.gray.opacity(0.5)) // Placeholder background color
                                        .cornerRadius(10)
                                    Text(block)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                    // Add onAppear modifier to load more blocks when reaching the end of the list
                    .onAppear {
                        if additionalBlocksLoaded == 0 {
                            loadMoreBlocks()
                            additionalBlocksLoaded += 1
                        }
                    }

                    Button(action: {
                        loadMoreBlocks()
                    }) {
                        Text("Load More Blocks")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1)) // Maroon background
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.horizontal)
                    }
                }
            }
            .tabItem {
                Label("Market", systemImage: "cart.fill")
            }

            // Search Tab
            Text("Profile View")
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }

            // Profile Tab
            Text("Search View")
                .tabItem {
                    Label("Search", systemImage: "bag.fill")
                }
        }
        .accentColor(Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1)) // Maroon color for selected tab bar item
    }

    // Function to load more blocks
    private func loadMoreBlocks() {
        let additionalBlocks = (blocks.count + 1...blocks.count + 4).map { "Product \($0)" } // Load additional blocks
        blocks.append(contentsOf: additionalBlocks) // Append additional blocks to the existing list
    }
}

struct ProductDetailView: View {
    let product: String

    var body: some View {
        Text("Details for \(product)")
            .navigationBarTitle(product, displayMode: .inline)
    }
}

struct Market_Previews: PreviewProvider {
    static var previews: some View {
        Market()
    }
}
