//
//  OrderDetailsView.swift
//  ZooKartFrontEnd
//
//  Created by Aaditya Saini on 2/18/24.
//

import SwiftUI

struct OrderDetailView: View { //Get Request JSON, then Parse
    let order: Order // change to Order

    var body: some View {
        NavigationStack {
            Text("Details for \(order.name)")
                .font(.headline)
            List {
                Text("Name: \(order.name)")
                Text("Order Type: \(order.toString)")
                Text("Seller: \(order.seller)")
                Text("Price: $\(order.price)")
                Text("Description: \(order.description)")
            }
        }
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static let testOrder1 = Order(orderKind: .product, price: 12, name: "Test Order 1", description: "This is the first test", seller: "ayush")
    static var previews: some View {
        OrderDetailView(order: testOrder1)
    }
}
