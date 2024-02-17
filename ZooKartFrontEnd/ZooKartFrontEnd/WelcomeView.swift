//
//  WelcomeView.swift
//  ZooKartFrontEnd
//
//  Created by Aaditya Saini on 2/17/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "z.square")
                        .resizable()
                        .frame(width: DrawingConstants.letterWidth)
                        .frame(height: DrawingConstants.letterWidth)
                    Image(systemName: "o.square")
                        .resizable()
                        .frame(width: DrawingConstants.letterWidth)
                        .frame(height: DrawingConstants.letterWidth)
                    
                    Image(systemName: "o.square")
                        .resizable()
                        .frame(width: DrawingConstants.letterWidth)
                        .frame(height: DrawingConstants.letterWidth)
                }
                HStack {
                    Image(systemName: "k.square")
                        .resizable()
                        .frame(width: DrawingConstants.letterWidth)
                        .frame(height: DrawingConstants.letterWidth)
                    Image(systemName: "a.square")
                        .resizable()
                        .frame(width: DrawingConstants.letterWidth)
                        .frame(height: DrawingConstants.letterWidth)
                    
                    Image(systemName: "r.square")
                        .resizable()
                        .frame(width: DrawingConstants.letterWidth)
                        .frame(height: DrawingConstants.letterWidth)
                    Image(systemName: "t.square")
                        .resizable()
                        .frame(width: DrawingConstants.letterWidth)
                        .frame(height: DrawingConstants.letterWidth)
                }
                
                Spacer()
                
                goToSignUp
                goToSignIn
            }
        }
    }
    
    var goToSignUp: some View {
        NavigationLink {
            Text("Worked")
        } label: {
            Text("Sign Up")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color(.sRGB, red: 128/255, green: 0, blue: 0, opacity: 1))
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
                .cornerRadius(10)
                .padding()
        }
    }
    
    var goToSignIn: some View {
        NavigationLink {
            
        } label: {
            Text("Already have an account? Log in here")
        }
    }
}


struct DrawingConstants {
    static let letterWidth: CGFloat = 90
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
