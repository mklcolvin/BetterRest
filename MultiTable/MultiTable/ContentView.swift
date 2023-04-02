//
//  ContentView.swift
//  MultiTable
//
//  Created by Mike Colvin on 3/1/23.
//

import SwiftUI
import AVFoundation     // Audio support for sound effects

struct ContentView: View {
    
    @State private var usedPrompts = [String]()
    @State private var tableStart = 2
    @State private var numberOfQuestions = 0
    @State private var score = 0
    @State private var showStartPanel = true
    @State private var userAnswer: Int?
    @State private var promptLine = ""
    @State private var rightAnswerStatus = true
    @State private var randNum = 0
    @State private var gameRounds = 0
    @State private var ballColor = Color.yellow
    @State private var animationAmount = 0.0
    @State private var gameOver = false
    @State private var questionCount = 0
    @State private var cheerSoundEffect: AVAudioPlayer?
    @State private var gaspSoundEffect: AVAudioPlayer?
    @State private var streakCount = 0             // Keeps track of streaks of 3 correct answers in a row

    private let questionRange = [5, 10, 20]
    private var answerTracker = [false, false, false]

    func startGame() {
        showStartPanel = false  // Hide the start panel
        userAnswer = nil
    }
    
    func restartGame() {
        showStartPanel = true // Show the start panel
        usedPrompts.removeAll()     // clears the past record of prompts
        questionCount = 0           // sets the question count back to zero
        score = 0                   // reset the score
    }
    
    func generateRandom() -> Int {
        return Int.random(in: 1...12)  // Generate random number from 1-12
    }
    
    func newRand() {
//       userAnswer = 0
        randNum = generateRandom()
        promptLine = "\(tableStart)      X      \(randNum)"


 //       gameRounds = questionRange[numberOfQuestions]
      }
    
    func checkAnswer(base: Int, multiplier: Int, answer: Int?) -> Bool {
        if (base * multiplier) == answer {
            return true
        } else {
            return false
        }
            
    }
    
    func addNewPrompt() {
        usedPrompts.insert(promptLine + "     =         " + String(userAnswer ?? 0), at: 0)
        newRand()
        questionCount += 1
        gameStatus(questionCount)
//        print("In addNewPrompt: userAnswer = \(userAnswer)")
        // exit if the remaining string is empty

        // extra validation to come
//        print("showStartPanel = \(showStartPanel)")
//        print("rightAnswerStatus = \(rightAnswerStatus)")

        userAnswer = nil      // reset the answer field

    }
    
    func gameStatus(_ currentQuestion: Int) {

        //  Sets the gameOver flag if we've reached the max # of questions to be asked
        print ("Current Question = \(currentQuestion),  Max Questions = \(numberOfQuestions)")
        if currentQuestion > numberOfQuestions - 1 {
            gameOver = true
            numberOfQuestions = 0
        }
    }
    
    func playCorrectSound ()
    {
        let path = Bundle.main.path(forResource: "yay.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            cheerSoundEffect = try AVAudioPlayer(contentsOf: url)
            cheerSoundEffect?.play()
        } catch {
            // couldn't load file :(
            print("Couldn't load yay.mp3")
        }
    }
    
    func playWrongSound ()
    {
        let path = Bundle.main.path(forResource: "gasp.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            gaspSoundEffect = try AVAudioPlayer(contentsOf: url)
            gaspSoundEffect?.play()
        } catch {
            // couldn't load file :(
            print("Couldn't load gasp.mp3")
        }
    }
    
    func playAwesomeSound ()
    {
        let path = Bundle.main.path(forResource: "awesome.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            gaspSoundEffect = try AVAudioPlayer(contentsOf: url)
            gaspSoundEffect?.play()
        } catch {
            // couldn't load file :(
            print("Couldn't load awesome.mp3")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                

                if showStartPanel {
                    Group {
                        Form {
                            Stepper("Which timestable to use:  \(tableStart)", value: $tableStart, in: 2...12, step: 1)
                            
                            Picker("Number of Questions", selection: $numberOfQuestions)
                            {
                                ForEach (questionRange, id: \.self) { index in
                                    Text("\(index)")

                                }
                            }
                            
                        }
                        
                        Button("Begin Game")
                        {
                            startGame()
                            newRand()
                        }
                        .bold()
                        
                    }  // End of Group
                    

                }


                Form {
                    if !showStartPanel {
                        HStack {
                            Text("\(promptLine)")
//                            TextField("Enter your answer", value: $userAnswer,
//                                format: .number)
//                                .multilineTextAlignment(.trailing)
//                                .keyboardType(.numberPad)
                        }
                    }
                }
                if !showStartPanel {
                    
                    Button("Submit")
                    {
                        rightAnswerStatus = checkAnswer(base: tableStart, multiplier: randNum, answer: userAnswer)
                        // animate for correct answer
                        if rightAnswerStatus {
                            self.ballColor = Color.green
                            streakCount += 1            // bump up the streak count
                            print("Streak Count = \(streakCount)")
                            if streakCount >= 3 {
                                playAwesomeSound()
                                streakCount = 0
                            } else {
                                playCorrectSound()
                            }
                            score += 1
                        }
                        else
                        {
                            self.ballColor = Color.red
                            playWrongSound()
                            streakCount = 0         // resets the streak, if there was one!

                        }
                        
                        withAnimation (.linear(duration: 2.0)) {
                            animationAmount += 360
                            self.ballColor = Color.yellow
                            
                        }
                        
                        //      Release the keyboard
                        
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        addNewPrompt()
                    }
                    .bold()
                }
                    

                if !showStartPanel {
                    ZStack {
                        Circle()
        //                    .fill (LinearGradient(colors: [.green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .fill(ballColor)
                        
                        TextField("Enter Answer Here", value: $userAnswer, format: .number)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .keyboardType(.numberPad)
                        
                    }
                    .rotation3DEffect(.degrees(animationAmount), axis: (x: 0.5, y: 0.5, z: 1))


                }

      
                if !showStartPanel {
                    List {
                        ForEach(usedPrompts, id: \.self) { word in
                            Text(word)
                        }
                    }
                }



                        Text("Your Score:  \(score)")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding()

                
            }  // End of Form
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("MultiTable!")
                            .font(Font.custom("ShortBaby", size: 52, relativeTo: .title))
                            .foregroundColor(.red)
                            .bold()
                    }
                }
            }

        }  // End of NavigationView
        .alert("End of Game Reached", isPresented: $gameOver) {
           // Button goes here
            Button("New Game", action: restartGame)
        } message: {
            Text("You got \(score) out of \(questionCount) questions right!")
        }
    }  // End of View
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
