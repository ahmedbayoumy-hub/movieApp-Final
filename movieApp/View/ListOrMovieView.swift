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
    @EnvironmentObject var viewModel: AppViewModel
    
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
                        ZStack {
                            Button {
                            } label: {
                            }.frame(height: 70)
                                .frame(maxWidth: 250)
                                .background(
                                    LinearGradient(colors: [.black, .blue],                   startPoint: .topLeading,                   endPoint: .bottomTrailing) // how to add a gradient to a button in SwiftUI
                                )
                                .cornerRadius(10)
                                .padding()
                            HStack {
                                Image(systemName: "film.stack.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color(uiColor: .white))
                                Text("TOP MOVIES")
                                    .font(Font.custom("Righteous-Regular", size: 25))
                                    .bold()
                                    .foregroundColor(.white)
                                
                            }
                            
                        }
                    }
                    
                    NavigationLink(destination: WatchListView()) {
                        ZStack {
                            Button {
                                print("movies pressed!")
                            } label: {
                            }.frame(height: 70)
                                .frame(maxWidth: 250)
                                .background(
                                    LinearGradient(colors: [.black, .blue],                   startPoint: .topLeading,                   endPoint: .bottomTrailing) // how to add a gradient to a button in SwiftUI
                                )
                                .cornerRadius(10)
                                .padding()
//                                .navigationBarBackButtonHidden(true)
                                
                            HStack {
                                Image(systemName: "list.bullet")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color(uiColor: .white))
                                Text("WATCH LIST")
                                    .font(Font.custom("Righteous-Regular", size: 25))
                                    .bold()
                                    .foregroundColor(.white)
                                
                            }
                            .navigationBarBackButtonHidden(true)
                        }
                    }
                }
            }
    }
}

struct ListOrMovieView_Previews: PreviewProvider {
    static var previews: some View {
        ListOrMovieView()
    }
}
