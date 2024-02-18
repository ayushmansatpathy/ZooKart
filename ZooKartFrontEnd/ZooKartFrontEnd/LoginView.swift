import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Spacer(minLength: geometry.size.height * 0.1) // Adds space at the top
                    
                    Text("ZooKart")
                        .font(.system(size: geometry.size.width * 0.1))
                        .padding(.top, geometry.size.height * 0.05)
                    
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5)
                        .shadow(radius: 10) // Shadow for the icon
                        .padding(.bottom, geometry.size.height * 0.05)
                    
                    // Login form content
                    VStack(spacing: 20) {
                        TextField("Username", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, geometry.size.width * 0.05)
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, geometry.size.width * 0.05)
                        
                        Button(action: logInAction) {
                            Text("Log In")
                                .foregroundColor(.white)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(isFormValid ? Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1) : Color.gray)
                                .cornerRadius(10)
                        }
                        .disabled(!isFormValid)
                        .padding(.horizontal, geometry.size.width * 0.05)
                        .shadow(color: .gray, radius: 5, x: 0, y: 2) // Adds a shadow beneath the button
                    }
                    .padding(.bottom, geometry.size.height * 0.02)
                    
                    Spacer() // Adjusts spacing at the bottom
                }
                .background(Color.white)
                .edgesIgnoringSafeArea(.top)
            }
        }
    }
    
    private var isFormValid: Bool {
        !username.isEmpty && !password.isEmpty
    }
    
    private func logInAction() {
        // Handle login action here
        print("Logging in...")
    }
}
