//
//  WatchListView.swift
//  movieApp
//
//  Created by Consultant on 1/27/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore




//


//func deleteData () {
//    Firestore.firestore().collection("movies").getDocuments() { (querySnapshot, err) in
//        if let err = err {
//            print("Error getting documents: \(err)")
//        } else {
//            for document in querySnapshot!.documents {
//                if document == document {
//                    print("\(document.documentID)")
//                }
//                 // Get documentID
////                Firestore.firestore().collection("movies").document(document.documentID).delete()
//            }
//        }
//    }
//}








struct WatchListView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @StateObject var MovieviewModel = ViewModel()
    let gradient = LinearGradient(colors: [Color.blue,Color.white],
                                      startPoint: .top, endPoint: .bottom)


    
    var body: some View {
        
        VStack {
//            NavigationView {
            if !viewModel.isSignedIn {
                Text("This Feature is Only Available to Users.")
                    .font(Font.custom("Righteous-Regular", size: 15))
                    .bold()
                    .foregroundColor(.red)
                    .padding(.bottom, 10)
                Text("Please Sign In or Create an Account.")
                    .font(Font.custom("Righteous-Regular", size: 15))
                    .bold()
                    .foregroundColor(.red)
            } else {
                List (MovieviewModel.moviesData) {movie in
                    HStack {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(movie.imageUrl)"))
                        {
                            image in image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 50, height: 80)
                        .cornerRadius(10)
                        VStack {
                            Text(movie.title)
                                .font(Font.custom("Righteous-Regular", size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .swipeActions {
                                    Button (role: .destructive)  {
                                        MovieviewModel.deleteMovies(movieDelete: movie)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                            
                        }
                        
                    }
                    
                    
                }
                
            }
                    
                }
                .navigationTitle("Watch List")
                .onAppear() {
                    MovieviewModel.loadMovies()
                }
                .toolbar {
                    if viewModel.isSignedIn {
                        NavigationLink(destination: LoginPage()) {
                            Text("Log Out")
                                .font(Font.custom("Righteous-Regular", size: 15))
                                .bold()
                                .foregroundColor(.blue)
                        }.simultaneousGesture(TapGesture().onEnded{
                            print("log Out pressed!")
                            try? Auth.auth().signOut()
                        })
                    }
                    else {
                        NavigationLink(destination: RegisterPage()) {
                            Text("Register")
                                .font(Font.custom("Righteous-Regular", size: 15))
                                .bold()
                                .foregroundColor(.blue)
                        }.simultaneousGesture(TapGesture().onEnded{
                            print("log Out pressed!")
                            try? Auth.auth().signOut()
                        })
                        NavigationLink(destination: LoginPage()) {
                            Text("Sign In")
                                .font(Font.custom("Righteous-Regular", size: 15))
                                .bold()
                                .foregroundColor(.blue)
                        }.simultaneousGesture(TapGesture().onEnded{
                            print("log Out pressed!")
                            try? Auth.auth().signOut()
                        })
                    }
                }
    }
}

struct WatchListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListView()
    }
}
