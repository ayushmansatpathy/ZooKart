import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var authManager: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                // Logo and name representation
                HStack {
                    Image(systemName: "z.square")
                        .resizable()
                        .frame(width: DrawingConstants.letterWidth, height: DrawingConstants.letterWidth)
                    Image(systemName: "o.square")
                        .resizable()
                        .frame(width: DrawingConstants.letterWidth, height: DrawingConstants.letterWidth)
                    Image(systemName: "o.square")
                        .resizable()
                        .frame(width: DrawingConstants.letterWidth, height: DrawingConstants.letterWidth)
                }
                HStack {
                    Image(systemName: "k.square")
                        .resizable()
                        .frame(width: DrawingConstants.letterWidth, height: DrawingConstants.letterWidth)
                    Image(systemName: "a.square")
                        .resizable()
                        .frame(width: DrawingConstants.letterWidth, height: DrawingConstants.letterWidth)
                    Image(systemName: "r.square")
                        .resizable()
                        .frame(width: DrawingConstants.letterWidth, height: DrawingConstants.letterWidth)
                    Image(systemName: "t.square")
                        .resizable()
                        .frame(width: DrawingConstants.letterWidth, height: DrawingConstants.letterWidth)
                }
                
                Spacer() // Reduced space to move buttons closer to center
                
                // Buttons for sign up and log in
                signUpButton
                logInButton
                
//                Spacer() // Maintains layout balance
            }
        }
    }
    
    var signUpButton: some View {
        NavigationLink(destination: SignUpView()) {
            Text("Sign Up")
                .font(.headline)
                .foregroundColor(Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1)) // Maroon font color
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white) // White background
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1), lineWidth: 2) // Maroon border
                        )
                )
                .cornerRadius(25) // Rounded edges
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
                .padding(.horizontal)
        }
        .padding(.top, 10) // Adjust spacing as needed
    }
    
    var logInButton: some View {
        NavigationLink(destination: LoginView()) {
            Text("Log In")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1)) // Maroon background
                .cornerRadius(25) // Rounded edges
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
                .padding(.horizontal)
        }
        .padding(.top, 10) // Creates space between the sign up and log in buttons
    }
}

struct DrawingConstants {
    static let letterWidth: CGFloat = 90
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(AuthViewModel())
    }
}
