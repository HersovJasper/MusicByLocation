//
//  ContentView.swift
//  MusicByLocation
//
//  Created by Jasper Hersov on 13/05/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationHandler = LocationHandler()
    
    var body: some View {
        VStack{
            Text(locationHandler.lastKnownLocation)
            Text(locationHandler.lastKnownCountry)
            Text("\(locationHandler.lastKnownCoordinate.0), \(locationHandler.lastKnownCoordinate.1)")
            Text(locationHandler.lastKnownAltitude)
            Spacer()
            Button("Find Music", action:{
                locationHandler.requestLocation()
            })
        }.onAppear(perform: {
            locationHandler.requestAuthorisation()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
