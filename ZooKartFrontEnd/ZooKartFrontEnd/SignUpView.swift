import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmedPassword: String = ""
    
    @State private var showConfirmation = false
    
    @EnvironmentObject var authManager: AuthViewModel
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack {
                    Text("ZooKart")
                        .font(.system(size: geometry.size.width * 0.1))
                        .padding(.top, geometry.size.height * 0.05)
                    
                    pfpImage
                    
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
                        
                        SecureField("Confirm Password", text: $confirmedPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, geometry.size.width * 0.05)
                        
                        Spacer()
                        
                        signUpButton

                    }
                    .padding(.bottom, geometry.size.height * 0.02)
                    
                    Spacer() // Adjusts spacing at the bottom
                }
                .background(Color.white)
            }
            .navigationDestination(isPresented: $authManager.validAuth) {
                WelcomeView()
            }
        }
        .alert(isPresented: $showConfirmation) {
            Alert(title: Text("Success"), message: Text("Sign up successful! Sign in with the previous login button to verify your account"), dismissButton: .default(Text("OK")))
        }
        
    }
    
    var pfpImage: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: DrawingConstants.pfpWidth, height: DrawingConstants.pfpWidth)
            .shadow(radius: 10)
            .padding(.bottom)
    }
    
    var signUpButton: some View {
        Button {
            guard isFormValid else {
                print("Fill out the form completely")
                return
            }
            Task {
                await authManager.signUp(email: email, password: password) // does not take name
                guard authManager.validSignUp else {
                    return
                }                
            }
            showConfirmation = true
        } label: {
            Text("Sign Up")
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(Color.maroon)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 5, x: 0, y: 2)
                .padding()
        }
    }
    
    private var isFormValid: Bool {
        !name.isEmpty && !email.isEmpty && !password.isEmpty && password == confirmedPassword
    }
    
    private struct DrawingConstants {
        static let pfpWidth: CGFloat = 200
    }
}

public extension Color {
    static var maroon = Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1)
}





struct SignUpViews_Preview: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthViewModel())
    }
}
