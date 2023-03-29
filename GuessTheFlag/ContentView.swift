//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mike Colvin on 12/15/22.
//

import SwiftUI

struct FlagImage: View {
    var text: String
    
    var body: some View {
        Image(text)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
        
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var gameOver = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var totalScore = 0
    @State private var numOfQuestions = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var whichFlagTapped = 0          // Which flag was tapped
    @State private var animationAmount = 0.0
    @State private var fade = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)],
                           center: .top, startRadius: 200, endRadius: 700)
            VStack {
                
                Spacer()
                
                Text("Guess the Flag")
                    .titleStyle()
                
                
                VStack (spacing: 15) {
                    VStack {
                        Text("Tap the flag of ")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(text: countries[number])

                        }
                        .opacity((fade && (number != whichFlagTapped)) ? 0.25 : 1)
                        .rotation3DEffect(.degrees(number == correctAnswer ? self.animationAmount : 0), axis: (x: 0, y: 1, z: 0))
//                        .onTapGesture() {
//                            withAnimation(.linear(duration: 2)) {
//                                fade.toggle()
//                            }
//                        }
 

                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your Score is \(userScore)")
        }
        .alert(scoreTitle, isPresented: $gameOver) {
           // Button goes here
        } message: {
            Text("Your Final Score is \(totalScore)")
        }
    }
    
    func flagTapped(_ number: Int) {
        
        // Update score if the guess is correct
        
        if number == correctAnswer {
            scoreTitle = "Correct!"
            whichFlagTapped = number
            print("Correct Flag tapped = \(whichFlagTapped)")
            userScore += 1
            fade.toggle()
            withAnimation() {
                        self.animationAmount += 360  // # of degrees to rotate flag
                    }
        }
        else
        {
            whichFlagTapped = number
            print("Wrong Flag tapped = \(whichFlagTapped)")
            scoreTitle = "Wrong!  That's the flag of \(countries[number])"
            userScore -= 1
            fade = false
        }
        
        totalScore = userScore      //Keep a running total of the score
        showingScore = true
//        print("Number of Questions = \(numOfQuestions)")
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        numOfQuestions += 1
        gameStatus(numOfQuestions)
        whichFlagTapped = 0
    }
    
    func gameStatus(_ numQuest: Int) {
        if numQuest > 7 {
            gameOver = true
            numOfQuestions = 0
            userScore = 0
            whichFlagTapped = 0
            scoreTitle = "Game OVER!"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
