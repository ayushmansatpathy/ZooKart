//import SwiftUI
//
//struct Market: View {
//    @State private var blocks = Array(1...8).map { "Product \($0)" } // Initial blocks
//    @State private var additionalBlocksLoaded = 0 // Tracks the number of additional blocks loaded
//
//    var body: some View {
//        TabView {
//            // Market Tab
//            NavigationStack {
//                ScrollView {
//                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
//                        ForEach(blocks, id: \.self) { block in
//                            NavigationLink(destination: ProductDetailView(product: block)) {
//                                VStack {
//                                    Image(systemName: "photo") // Placeholder image
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(width: 100, height: 100)
//                                        .background(Color.gray.opacity(0.5)) // Placeholder background color
//                                        .cornerRadius(10)
//                                    Text(block)
//                                        .padding()
//                                        .frame(maxWidth: .infinity)
//                                        .background(Color.white)
//                                        .cornerRadius(10)
//                                        .shadow(radius: 5)
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//                    }
//                    .padding(.top)
//                    // Add onAppear modifier to load more blocks when reaching the end of the list
//                    .onAppear {
//                        if additionalBlocksLoaded == 0 {
//                            loadMoreBlocks()
//                            additionalBlocksLoaded += 1
//                        }
//                    }
//
//                    Button(action: {
//                        loadMoreBlocks()
//                    }) {
//                        Text("Load More Blocks")
//                            .foregroundColor(.white)
//                            .font(.headline)
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1)) // Maroon background
//                            .cornerRadius(10)
//                            .shadow(radius: 5)
//                            .padding(.horizontal)
//                    }
//                }
//            }
//            .tabItem {
//                Label("Market", systemImage: "cart.fill")
//            }
//
//            // Search Tab
//            Text("Profile View")
//                .tabItem {
//                    Label("Profile", systemImage: "person.fill")
//                }
//
//            // Profile Tab
//            Text("Search View")
//                .tabItem {
//                    Label("Search", systemImage: "bag.fill")
//                }
//        }
//        .accentColor(Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1)) // Maroon color for selected tab bar item
//    }
//
//    // Function to load more blocks
//    private func loadMoreBlocks() {
//        let additionalBlocks = (blocks.count + 1...blocks.count + 4).map { "Product \($0)" } // Load additional blocks
//        blocks.append(contentsOf: additionalBlocks) // Append additional blocks to the existing list
//    }
//}
//
//struct ProductDetailView: View {
//    let product: String
//
//    var body: some View {
//        Text("Details for \(product)")
//            .navigationBarTitle(product, displayMode: .inline)
//    }
//}
//
//struct Market_Previews: PreviewProvider {
//    static var previews: some View {
//        Market()
//    }
//}

//import SwiftUI
//
//struct Product: Identifiable {
//    let id = UUID()
//    var title: String
//    // Add more properties as needed
//}
//
//struct Market: View {
//    // Initialize with 10 products
//    @State private var products: [Product] = (1...10).map { Product(title: "Product \($0)") }
//
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
//                    ForEach(products) { product in
//                        NavigationLink(destination: ProductDetailView(product: product.title)) {
//                            VStack {
//                                Image(systemName: "square.fill")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 125, height: 125) // Making the image square
//                                    .foregroundColor(.white) // Maroon color for the image
//                                    .background(Color.maroon.opacity(0.25)) // Placeholder background color
//                                    .cornerRadius(10)
//
//                                Text(product.title)
//                                    .font(.headline) // Consistent font style
//                                    .foregroundColor(Color.maroon) // White text
//                                    .padding(5)
//                                    .cornerRadius(5)
//                            }
//                            .shadow(radius: 5)
//                        }
//                        .buttonStyle(PlainButtonStyle()) // Removes any default styling from the button
//                        .padding(.horizontal)
//                    }
//                }
//                .padding(.top)
//            }
//            .navigationTitle("Products")
//            .background(Color.white)
//        }
//    }
//}
//
//struct ProductDetailView: View {
//    let product: String
//
//    var body: some View {
//        Text("Details for \(product)")
//            .navigationBarTitle(Text(product), displayMode: .inline)
//            .foregroundColor(.maroon)
//    }
//}



import SwiftUI

struct Product: Codable, Identifiable {
    let date_added: String?
    let description: String?
    let id: Int
    let price: Int
    let seller: String
    let title: String
    let buyer: String?
}
struct Service: Codable, Identifiable{
    let buyer: [String]
    let description: String?
    let date_added: String?
    let id: Int
    let price: Int
    let seller: String
    let title: String
}

struct Market: View {
    @State private var products: [Product] = []
    @State private var services: [Service] = []
    
    var body: some View {
            TabView {
                NavigationStack {
                    VStack{
                        HStack {
                        Text("Products")
                            .font(.title) // Set the font size and style
                            .fontWeight(.bold) // Set the font weight
                            .multilineTextAlignment(.leading) // Align text to the left
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        Spacer() // Pushes the button to the top
                        
                            Spacer() // Pushes the button to the right
                            NavigationLink(destination: Text("ADD ITEM VIEW")) {
                                Image(systemName: "plus")
                                .foregroundColor(.black)
                                .padding(.horizontal)
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal)
                        }
                        
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                                ForEach(products) { Product in
                                    NavigationLink(destination: ProductDetailView(product: Product)) {
                                        VStack {
                                            Image(systemName: "photo") // Placeholder image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 150, height: 100)
                                                .cornerRadius(10)
                                            Text(Product.title)
                                                .padding(1)
                                                .frame(maxWidth: .infinity)
                                                .cornerRadius(10)
                                                .shadow(radius: 5)
                                            
                                        }
                                        .padding(15)
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.top)
                        }
                        .onAppear {
                            Task {
                                    do {
                                        try await getProducts()
                                    } catch {
                                        print(error)
                                    }
                            }
                        }
                    }
                }
                .tabItem {
                    Label("Market", systemImage: "cart.fill")
                }
                
                ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                    
    
                NavigationStack {
                    VStack{
                        HStack {
                            Text("Services")
                                .font(.title) // Set the font size and style
                                .fontWeight(.bold) // Set the font weight
                                .multilineTextAlignment(.leading) // Align text to the left
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            Spacer() // Pushes the button to the top
                            
                            Spacer() // Pushes the button to the right
                            
                            NavigationLink(destination: Text("ADD ITEM VIEW")) {
                                Image(systemName: "plus")
                                .foregroundColor(.black)
                                .padding(.horizontal)
                            }
                        }
                        
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                                ForEach(services) { Service in
                                    NavigationLink(destination: ServiceDetailView(service: Service)) {
                                        VStack {
                                            Image(systemName: "photo") // Placeholder image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 150, height: 100)
                                                .cornerRadius(10)
                                            Text(Service.description ?? "default value")
                                                .padding(1)
                                                .frame(maxWidth: .infinity)
                                                .cornerRadius(10)
                                                .shadow(radius: 5)
                                            
                                        }
                                        .padding(15)
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.top)
                        }
                        .onAppear {
                            Task {
                                    do {
                                        try await getServices()
                                    } catch {
                                        print(error)
                                    }
                            }
                        }
                    }
                }
                    .tabItem {
                        Label("Search", systemImage: "bag.fill")
                    }
            }
        .accentColor(Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1)) // Maroon color for selected tab bar item
    }
    
    func getProducts() async throws {
        self.products=[]
        guard let url = URL(string: "http://127.0.0.1:5000/products") else { fatalError("Missing URL") }
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            let decodedProduct = try JSONDecoder().decode([Product].self, from: data)
        for product in decodedProduct{
            if product.buyer == nil{
                self.products.append(product)
            }
        }
        print("Async decodedProduct", decodedProduct)
    }
    
    
    func getServices() async throws {
        self.services=[]
        guard let url = URL(string: "http://127.0.0.1:5000/services") else { fatalError("Missing URL") }
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            let decodedService = try JSONDecoder().decode([Service].self, from: data)
        self.services=decodedService
        print("Async decodedProduct", decodedService)
    }
}


struct ProductDetailView: View {
    func updateProduct(productId:Int, buyer:String) {
            guard let url = URL(string: "http://127.0.0.1:5000/update_product/\(productId)") else {
                print("Invalid URL")
                return
            }
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: ["buyer": buyer]) else {
                print("Failed to serialize JSON data")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    print("Product updated successfully")
                    // Handle success if needed
                } else {
                    print("Failed to update product. Status code: \(httpResponse.statusCode)")
                    // Handle failure if needed
                }
            }.resume()
        }
    let product: Product

    var body: some View {
        Text("Details")
            .navigationBarTitle(product.title, displayMode: .inline)
        List{
            Text("Seller: \(product.seller)")
            Text("Price: $\(product.price)")
            Text("Date Added: \(product.date_added ?? "Date()")")
            Text("Description: \(product.description ?? "")")
            Button("Buy Item") {
                updateProduct(productId: product.id, buyer: "yeet")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .font(.headline)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        
        
    }
}

struct ServiceDetailView: View {
    func updateService(serviceId:Int, buyer:String) {
            guard let url = URL(string: "http://127.0.0.1:5000/update_service/\(serviceId)") else {
                print("Invalid URL")
                return
            }
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: ["buyer": buyer]) else {
                print("Failed to serialize JSON data")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    print("Product updated successfully")
                    // Handle success if needed
                } else {
                    print("Failed to update product. Status code: \(httpResponse.statusCode)")
                    // Handle failure if needed
                }
            }.resume()
        }
    
    let service: Service

    var body: some View {
        Text("Details")
            .navigationBarTitle(service.title, displayMode: .inline)
        List{
            Text("Seller: \(service.seller)")
            Text("Price: $\(service.price)")
            Text("Description: \(service.description ?? "")")
            Button("Book Service") {
                updateService(serviceId: service.id, buyer: "yeet")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .font(.headline)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        
        
    }
}

struct Market_Previews: PreviewProvider {
    static var previews: some View {
        Market()
    }
}

