import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            // Profile Image
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
                .padding(.top, 50)

            // Name
            Text("Bob Jones")
                .font(.title)
                .fontWeight(.medium)

            // Email
            Text("bobby@umass.edu")
                .font(.subheadline)
                .foregroundColor(.gray)

            // Navigation Link to Recent Orders
            NavigationLink(destination: RecentOrdersView()) {
                Text("Recent Orders")
                    .foregroundColor(.blue)
            }

            Spacer()
                Text("Log Out")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            .padding(.bottom, 50) // Adds padding at the bottom of the button
        }
        .padding()
        .navigationBarTitle("Profile", displayMode: .inline)
    }
}
struct SwiftUIViewProfile_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SwiftUIView()
        }
    }
}
