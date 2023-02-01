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

    
    let gradient = LinearGradient(colors: [Color(UIColor(red: 0.95, green: 0.94, blue: 0.88, alpha: 1.00)),Color(UIColor(red: 1.00, green: 0.92, blue: 0.68, alpha: 1.00))], startPoint: .bottom, endPoint: .top)
    
    @EnvironmentObject var viewModel: AppViewModel
    
    init() {
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.blue]
    }
    
    
    var body: some View {
        
        
        
        
        
            NavigationView{
                if viewModel.isSignedIn {
                    ListOrMovieView().environmentObject(viewModel)
                } else {
                ZStack {
                    Image("movieGrain").resizable().aspectRatio(UIImage(named: "movieGrain")!.size, contentMode: .fill).ignoresSafeArea()
                    //                    gradient
                    //                        .opacity(0.35)
                    //                        .ignoresSafeArea()
                    
                    VStack {
                        HStack{
                            Image(systemName: "popcorn.fill")
                                .resizable()
                                .frame(width: 50, height: 70)
                                .padding(.bottom, 100)
                                .foregroundStyle(
                                    gradient
                                )
                            
                            Text("Moviez")
                            //                            .padding(.bottom, 100)
                            //                            .font(Font.custom("Rubik80sFade-Regular", size: 40))
                                .font(Font.custom("FascinateInline-Regular", size: 50))
                                .bold()
                                .padding(.bottom, 100)
                                .foregroundStyle(gradient)
                        }
                        
                        
                        NavigationLink(destination: LoginPage()) {
                            ZStack {
                                Button {
                                } label: {
                                    
                                }.frame(height: 50)
                                    .frame(maxWidth: 250)
                                    .background(gradient)
                                    .cornerRadius(10)
                                
                                Text("Sign In")
                                    .font(Font.custom("Righteous-Regular", size: 20))
                                    .bold()
                                    .foregroundColor(.black)
                                
                            }
                        }
                        NavigationLink(destination: RegisterPage()) {
                            ZStack {
                                
                                Button {
                                } label: {
                                }.frame(height: 50)
                                    .frame(maxWidth: 250)
                                    .background(gradient)
                                    .cornerRadius(10)
                                //
                                
                                Text("Create an Account")
                                    .font(Font.custom("Righteous-Regular", size: 20))
                                    .bold()
                                    .foregroundColor(.black)
                            }
                        }
                        NavigationLink(destination: ListOrMovieView()) {
                            ZStack {
                                
                                Button {
                                } label: {
                                }
                                .frame(height: 50)
                                    .frame(maxWidth: 150)
                                    .background(gradient)
                                    .cornerRadius(10)
                                Text("Free Version")
                                    .font(Font.custom("Righteous-Regular", size: 20))
                                    .bold()
                                    .foregroundColor(.black)
                            }
                        }.padding(.top, 200)
                            
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

