import SwiftUI

struct RecentOrdersView: View {
    let orders = ["Order 1", "Order 2", "Order 3"] // Sample data for demonstration
    // var orders: [Order]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(orders, id: \.self) { order in
                        NavigationLink(destination: Text("ORDER")) {
                            OrderCardView(orderName: order)
                        }
                    }
                }
                .padding(.top) // Add some padding at the top of the VStack
            }
            .navigationBarTitle("Recent Orders", displayMode: .inline)
            .background(Color.gray.opacity(0.1)) // Optional: Set a background color for the ScrollView
        }
    }
    
    struct OrderCardView: View {
        var orderName: String
        
        var body: some View {
            Text(orderName)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1)) // Maroon background
                .foregroundColor(.white) // White text color
                .cornerRadius(10) // Rounded corners
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1), lineWidth: 2) // Maroon border
                )
                .shadow(radius: 5) // Shadow for a lifted card effect
                .padding(.horizontal) // Horizontal padding to the VStack for better alignment
        }
    }
}

enum OrderType {
    case service
    case product
}

struct Order {
    let orderKind: OrderType
    let price: Int
    let name: String
    let description: String
    let seller: String
    
    var toString: String {
        switch self.orderKind {
        case .service:
            return "Service"
        case .product:
            return "Product"
        }
    }
}

// Preview Provider
struct RecentOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        RecentOrdersView()
    }
}
