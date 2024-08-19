//
//  ContentView.swift
//  Test Animation App
//
//  Created by Mike Colvin on 3/23/23.
//

import SwiftUI

struct ContentView: View {
    @State private var userEntry = ""
    @State private var rightWrong = false
    @State private var isRotated = true
    @State private var animationAmount = 0.0
    @State private var ballColor = Color.yellow
    
    
    var animation: Animation {
        Animation.easeOut
    }
    
    var body: some View {
        Group {
            ZStack {
                Circle()
//                    .fill (LinearGradient(colors: [.green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .fill(ballColor)
                
                TextField("Enter Answer Here", text: $userEntry)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0.5, y: 0.5, z: 1))
            
            Button ("Submit") {
                print("userEntry = \(userEntry)")
                print("ballColor = \(ballColor)")
                print("rightWrong = \(rightWrong)")
//                self.ballColor = (self.ballColor == Color.yellow) && (rightWrong == true) ? Color.green : Color.yellow
//
//                self.ballColor = (self.ballColor == Color.yellow) && (rightWrong == false) ? Color.red : Color.yellow

                if rightWrong {
                    self.ballColor = Color.green
                } else {
                    self.ballColor = Color.red
                }
                
                withAnimation {
                    animationAmount += 360
                    self.ballColor = Color.yellow
                }
            }

        }
//        Circle()
//            .fill(self.rightWrong ? Color(.green) : .red)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
