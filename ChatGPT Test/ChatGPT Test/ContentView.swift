//
//  ContentView.swift
//  ChatGPT Test
//
//  Created by Mike Colvin on 3/27/23.
//

import SwiftUI
 
struct ContentView: View {
    @State private var degrees = 0.0
    @State private var color = Color.green
    @State private var text = ""
   
    var body: some View {
        VStack {
            Circle()
                .fill(color)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(degrees))
                .animation(.easeInOut(duration: 1))
           
            TextField("Enter text here", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
           
            Button(action: {
                self.color = self.color == Color.green ? Color.blue : Color.green
                self.degrees += 360
            }) {
                Text("Submit")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
