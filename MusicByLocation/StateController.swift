//
//  StateController.swift
//  MusicByLocation
//
//  Created by Jasper Hersov on 17/05/2021.
//

import Foundation

class StateController: ObservableObject {
    let locationHandler: LocationHandler = LocationHandler()
    let iTunesAdaptor = ITunesAdaptor()
    @Published var artistsByLocation: [Artist] = []
    
    var lastKnownLocation: String = ""{
        didSet { //property observer
            iTunesAdaptor.getArtists(search: lastKnownLocation, completion: updateArtistsByLocation)
        }
    }
    
    func findMusic() {
        locationHandler.requestLocation()
    }
    
    func requestAccessToLocationData() {
        locationHandler.stateController = self
        locationHandler.requestAuthorisation()
    }
    
    func updateArtistsByLocation(artists: [Artist]?) {
        DispatchQueue.main.async{
            self.artistsByLocation = artists ?? [Artist(name: "Error", url: "https://google.com")]
        }
    }
}

