import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
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
                        .shadow(radius: 10)
                        .padding(.bottom, geometry.size.height * 0.05)
                    
                    // Sign-up form content
                    VStack(spacing: 20) {
                        TextField("Name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, geometry.size.width * 0.05)
                        
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, geometry.size.width * 0.05)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, geometry.size.width * 0.05)
                        
                        SecureField("Confirm Password", text: $confirmPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, geometry.size.width * 0.05)
                        
                        Button(action: signUpAction) {
                            Text("Sign Up")
                                .foregroundColor(.white)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(isFormValid ? Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1) : Color.gray)
                                .cornerRadius(10)
                        }
                        .disabled(!isFormValid)
                        .padding(.horizontal, geometry.size.width * 0.05)
                        .shadow(color: .gray, radius: 5, x: 0, y: 2)
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
        !name.isEmpty && !email.isEmpty && !password.isEmpty && password == confirmPassword
    }
    
    private func signUpAction() {
        // Handle sign-up action here
        print("Signing up...")
    }
}
