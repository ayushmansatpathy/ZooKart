import SwiftUI

struct RecentOrdersView: View {
    let orders = ["Order 1", "Order 2", "Order 3"] // Sample data for demonstration

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(orders, id: \.self) { order in
                    NavigationLink(destination: OrderDetailView(order: order)) {
                        Text(order)
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
            .padding(.top) // Add some padding at the top of the VStack
        }
        .navigationBarTitle("Recent Orders", displayMode: .inline)
        .background(Color.gray.opacity(0.1)) // Optional: Set a background color for the ScrollView
    }
}

// Example destination view for demonstration purposes
struct OrderDetailView: View { //Get Request JSON, then Parse
    let order: String

    var body: some View {
        Text("Details for \(order)")
            .navigationBarTitle("Order Details", displayMode: .inline)
    }
}

// Preview Provider
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecentOrdersView()
        }
    }
}
