import Foundation
import FirebaseAuth

@MainActor
class AuthViewModel: ObservableObject {
    
//    let currUser = Auth.auth().currentUser
    @Published var user: User?
    @Published var validAuth = false
    @Published var validSignUp = false
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?

    
    init() {
        registerAuthStateHandler()
    }
    
    
    func registerAuthStateHandler() {
        authStateHandler = Auth.auth().addStateDidChangeListener{ auth, user in
            self.user = user
            
        }
    }

    func signIn(with email: String, and password: String) async {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            validAuth = true
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func signUp(email: String, password: String) async {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            validSignUp = true
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    func deleteAccount() async {
        do {
            try await user?.delete()
            validAuth = false
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

//public var globalUser: User?

class UserWrapper: ObservableObject {
    @Published var user: User

    init(user: User) {
        self.user = user
    }
}

//public var userId = "Default User ID"
