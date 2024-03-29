import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @EnvironmentObject var authManager: AuthViewModel
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
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
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, geometry.size.width * 0.05)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, geometry.size.width * 0.05)
                            .autocapitalization(.none)
                        
                        Button(action: logInAction) {
                        
                            Text("Log In")
                                .foregroundColor(.white)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(Color.maroon)
                                .cornerRadius(10)
                        }
//                        .disabled(!isFormValid)
                        .padding(.horizontal, geometry.size.width * 0.05)
                        .shadow(color: .gray, radius: 5, x: 0, y: 2) // Adds a shadow beneath the button
                    }
                    .padding(.bottom, geometry.size.height * 0.02)
                    
                    Spacer() // Adjusts spacing at the bottom
                }
                .background(Color.white)
                .edgesIgnoringSafeArea(.top)
            }
            .navigationDestination(isPresented: $authManager.validAuth) {
                HomeView()
            }
        }
        
    }
    
    var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    private func logInAction() {
        // Handle login action here
        print("LogIn Pressed")
        guard isFormValid else {
            print("Fill out the form completely")
            return
        }
        Task {
            await authManager.signIn(with: email, and: password)
            guard authManager.validAuth else {
                return
            }
            authManager.validAuth = true
        }
    }
    
}

//struct LoginView_Preview {
//    static var previews: some View {
//        LoginView(authManager: AuthViewModel())
//    }
//}
