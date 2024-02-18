//
//  HomeView.swift
//  ZooKartFrontEnd
//
//  Created by Aaditya Saini on 2/18/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authManager: AuthViewModel
    var body: some View {
        TabView {
            Text(authManager.user?.uid ?? "default UID")
                .tabItem {
                    Label("Products", systemImage: "cart.fill")
                }
            Text("Profile Screen")
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            Text("Services Screen")
                .tabItem {
                    Label("Services", systemImage: "wrench")
                }
            Market()
                .tabItem {
                    Label("Services", systemImage: "wrench")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthViewModel())
    }
}
