import SwiftUI

struct ProfileView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer(minLength: geometry.size.height * 0.1)
                
                Text("ZooKart")
                    .font(.system(size: geometry.size.width * 0.1))
                    .padding(.top, geometry.size.height * 0.05)
                
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5)
                    .shadow(radius: 10)
                    .padding(.bottom, geometry.size.height * 0.05)
                
                Text("Bob Jones")
                    .font(.title)
                    .fontWeight(.medium)
                
                Text("bobby@umass.edu")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer() // Add spacer for spacing
                
                HStack(spacing: 10) { // Container for side by side buttons
                    // Your Posts Button
                    Button("Your Posts") {
                        // Handle your posts action
                    }
                    .foregroundColor(.white) // Changed font color to white
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1)) // Maroon background
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 5, x: 0, y: 2)
                    
                    // Recent Orders Button
                    NavigationLink(destination: RecentOrdersView()) {
                        Text("Recent Orders")
                            .foregroundColor(.white) // Now white text
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1)) // Maroon background
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 5, x: 0, y: 2)
                    }
                }
                .padding(.horizontal, geometry.size.width * 0.05)
                .padding(.bottom, 10) // Add padding between buttons
                
                Button("Log Out") {
                    // Handle log out action
                }
                .foregroundColor(Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1)) // Maroon font color now
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white) // White background now
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1), lineWidth: 2) // Maroon border
                )
                .shadow(color: .gray, radius: 5, x: 0, y: 2)
                .padding(.horizontal, geometry.size.width * 0.05)
                .padding(.bottom, 50) // Adds padding at the bottom
                
            }
            .background(Color.white)
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitle("Profile", displayMode: .inline)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
