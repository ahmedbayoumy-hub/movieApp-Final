//
//  ViewModel.swift
//  movieApp
//
//  Created by Consultant on 1/7/23.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class ViewModel: ObservableObject {
    @Published var movies: Movie = Movie(results: [Result(title: "DNE", overview: "DNE", release_date: "DNE", vote_average: -1.0, poster_path: "", id: -1)])
    @Published var idToResultDic: [Int:Result] = [-1: Result(title: "DNE", overview: "DNE", release_date: "DNE", vote_average: -1.0, poster_path: "", id: -1)]
    
    @Published var db = Firestore.firestore()

    @Published var moviesData: [MovieListModel] = []
    
    func deleteMovies (movieDelete: MovieListModel) {
        Firestore.firestore().collection("movies").document(movieDelete.id).delete()
    }
    

    func loadMovies() {
        
        db.collection("movies")
            .order(by: "date")
            .addSnapshotListener { querySnapshot, error in
                self.moviesData = []
                if let e = error {
                    print("There was an issue retrieving data from Firestore, \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let sender = data["sender"] as? String,
                               let movieTitle = data ["title"] as? String,
                               let imageUrl = data ["imageUrl"] as? String
                            {
                                let newMovie = MovieListModel(id: doc.documentID, sender: sender, title: movieTitle, imageUrl: imageUrl )
                                self.moviesData.append(newMovie)
                            }
                        }
                    }
                }
            }
    }
    
    
    
    func fetch () {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=9e1d8923520bd266b373cf8eb02c7f6b&language=en-US&page=1") else {
            print ("url not valid")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let movies = try JSONDecoder().decode(Movie.self, from: data)
                
                DispatchQueue.main.async {
                    self.movies = movies
                    self.detailInfo(info: self.movies)
                }

            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func detailInfo (info: Movie) {
        var movieInfo: [Int : Result] = [:]
        for theResult in info.results
        {
            movieInfo[theResult.id] = theResult
        }
        self.idToResultDic = movieInfo
        
    }
    
}

