//
//  MovieDetails.swift
//  movieApp
//
//  Created by Consultant on 1/8/23.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore


struct MovieDetailView: View {
    
    
    let movieResult: Result
    let db = Firestore.firestore()
    
    init(_ movieInfo: Result)
    {
        movieResult = movieInfo
    }
    
    func addMovie () {
        let movieTitle = movieResult.title
        let movieSender = Auth.auth().currentUser?.email
        let imageUrl = movieResult.poster_path
        var ref: DocumentReference? = nil
        ref = db.collection("movies").addDocument (data: [
            "imageUrl": imageUrl ,
            "sender": movieSender,
            "title": movieTitle,
            "date": Date().timeIntervalSince1970
        ]) { (error) in
            if let e = error {
                print("there was issue saving data to firestore, \(e)")
            } else {
                print("successfully saved data")
            }
        }
    }
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        
            ZStack {
                VStack {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(movieResult.poster_path)"))
                    {
                        image in image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 150, height: 220)
                    .cornerRadius(10)
                    
                        Text (movieResult.title)
                            .padding()
                            .bold()
                            .font(Font.custom("Righteous-Regular", size: 20))
                        Text (movieResult.overview)
                            .padding()
                            .bold()
                            .foregroundColor(Color(uiColor: .systemGray))
                            .font(Font.custom("Righteous-Regular", size: 13))
                        Text ("Release Date: \(movieResult.release_date)")
                            .padding()
                            .bold()
                            .font(Font.custom("Righteous-Regular", size: 15))
                        Text ("Rating: \(String(format: "%.1f", movieResult.vote_average))")
                            .bold()
                            .padding()
                            .font(Font.custom("Righteous-Regular", size: 15))
                    if viewModel.isSignedIn {
                        ZStack {
                            Button {
                                addMovie()
                            } label: {
                                HStack {
                                    Text("Add to List")
                                        .font(Font.custom("Righteous-Regular", size: 20))
                                        .bold()
                                        .foregroundColor(.white)
                                    Image(systemName: "plus.app")
                                        .foregroundColor(Color(uiColor: .white))
                                }
                                
                            }.frame(height: 35)
                                .frame(maxWidth: 180)
                                .background(
                                    LinearGradient(colors: [.black, .blue],                   startPoint: .topLeading,                   endPoint: .bottomTrailing) // how to add a gradient to a button in SwiftUI
                                )
                                .cornerRadius(10)
                                .padding()
                        }
                    } else {
                        Text("Sign in to add to watch list!")
                            .font(Font.custom("Righteous-Regular", size: 12))
                            .bold()
                            .foregroundColor(.red)
                    }
                    
                    
                }
            } .toolbar {
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
