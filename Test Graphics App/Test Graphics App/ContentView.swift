//
//  ContentView.swift
//  Test Graphics App
//
//  Created by Mike Colvin on 3/23/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userEntry = ""
    
    var body: some View {
        Group {
            ZStack {
                Circle()
                    .foregroundColor(.blue)
                TextField("Type", text: $userEntry)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            .padding()
        }
        Group {
            Text("You Entered: \(userEntry)")
                .foregroundColor(.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
