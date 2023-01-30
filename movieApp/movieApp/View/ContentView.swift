//
//  ContentView.swift
//  movieApp
//
//  Created by Consultant on 1/6/23.
//

import SwiftUI
import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn (email: String, password: String) {
        auth.signIn(withEmail: email, password: password) {
            result, error in
            if let e = error {
                print("error signing in: \(e)")
            } else {
                return
            }
            //success
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let e = error {
                print("error signing up: \(e)")
            } else {
                return
            }
            //success
        }
    }
}


struct ContentView: View {
    
    @State private var isActive: Bool = false
    
    var body: some View {
        let gradient = LinearGradient(colors: [Color.blue,Color.white],
                                          startPoint: .top, endPoint: .bottom)
        NavigationView{
            ZStack {
                gradient
                    .opacity(0.50)
                    .ignoresSafeArea()
                
                VStack {
                    HStack{
                        Image(systemName: "popcorn.fill")
                            .resizable()
                            .frame(width: 50, height: 70)
                            
                        Text("Moviez")
//                            .padding(.bottom, 100)
//                            .font(Font.custom("Rubik80sFade-Regular", size: 40))
                            .font(Font.custom("FascinateInline-Regular", size: 50))
                            .bold()
                    }
                    
                    NavigationLink(destination: LoginPage()) {
                        Button {
                            print("Signin pressed")
                            } label: {
                            Text("Sign In")
                                .font(Font.custom("Righteous-Regular", size: 20))
                                .bold()
                                .foregroundColor(.white)
                        }.frame(height: 50)
                            .frame(maxWidth: 250)
                            .background(
                               LinearGradient(colors: [.black, .blue],                   startPoint: .topLeading,                   endPoint: .bottomTrailing) // how to add a gradient to a button in SwiftUI
                            )
                            .cornerRadius(10)
                            .padding()
                    }
                    NavigationLink(destination: RegisterPage()) {
                        Button {
                            print("create pressed")
                            } label: {
                            Text("Create an Account")
                                .font(Font.custom("Righteous-Regular", size: 20))
                                .bold()
                                .foregroundColor(.white)
                        }.frame(height: 50)
                            .frame(maxWidth: 250)
                            .background(
                               LinearGradient(colors: [.black, .blue],                   startPoint: .topLeading,                   endPoint: .bottomTrailing) // how to add a gradient to a button in SwiftUI
                            )
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
            

        }

    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
