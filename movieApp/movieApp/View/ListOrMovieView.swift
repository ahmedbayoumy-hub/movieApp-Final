//
//  ListOrMovieView.swift
//  movieApp
//
//  Created by Consultant on 1/27/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore



struct ListOrMovieView: View {
    
    let gradient = LinearGradient(colors: [Color.blue,Color.white],
                                      startPoint: .top, endPoint: .bottom)
    var body: some View {
//        NavigationView {
            ZStack {
                gradient
                    .opacity(0.50)
                    .ignoresSafeArea()
                VStack {
                    NavigationLink(destination: MovieList()) {
                        Button {
                            print("Signin pressed")
                            } label: {
                            Text("MOVIES")
                                    .font(Font.custom("Righteous-Regular", size: 25))
                                .bold()
                                .foregroundColor(.white)
                        }.frame(height: 250)
                            .frame(maxWidth: 250)
                            .background(
                               LinearGradient(colors: [.black, .blue],                   startPoint: .topLeading,                   endPoint: .bottomTrailing) // how to add a gradient to a button in SwiftUI
                            )
                            .cornerRadius(10)
                            .padding()
                    }
                    
                    NavigationLink(destination: WatchListView()) {
                        Button {
                            print("Signin pressed")
                            } label: {
                            Text("LIST")
                                    .font(Font.custom("Righteous-Regular", size: 25))
                                .bold()
                                .foregroundColor(.white)
                            }.frame(height: 250)
                            .frame(maxWidth: 250)
                            .background(
                               LinearGradient(colors: [.black, .blue],                   startPoint: .topLeading,                   endPoint: .bottomTrailing) // how to add a gradient to a button in SwiftUI
                            )
                            .cornerRadius(10)
                            .padding()
                            .navigationBarBackButtonHidden(true)
                    }
                }
            }
//        }
    }
}

struct ListOrMovieView_Previews: PreviewProvider {
    static var previews: some View {
        ListOrMovieView()
    }
}
