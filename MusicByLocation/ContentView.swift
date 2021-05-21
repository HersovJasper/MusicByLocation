//
//  ContentView.swift
//  MusicByLocation
//
//  Created by Jasper Hersov on 13/05/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var state = StateController()
    
    var body: some View {
        Form{
            List(state.artistsByLocation, id: \.self) { item in
                Link(item.name, destination: URL(string: "\(item.url)")!)
            }
            
        }.onAppear(perform: {
            state.requestAccessToLocationData()
        })
        
        Button("Find Music", action:{
            state.findMusic()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
