//
//  ContentView.swift
//  MultiTable
//
//  Created by Mike Colvin on 3/1/23.
//

import SwiftUI

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
    
    @State private var animationAmount = 0
    
    private let questionRange = [5, 10, 20]
    
    func startGame() {
        showStartPanel = false  // Hide the start panel
        userAnswer = nil
    }
    
    func restartGame() {
        showStartPanel = true // Show the start panel
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
//        print("In addNewPrompt: userAnswer = \(userAnswer)")
        // exit if the remaining string is empty

        // extra validation to come
        print("showStartPanel = \(showStartPanel)")
        print("rightAnswerStatus = \(rightAnswerStatus)")

        userAnswer = nil      // reset the answer field
//        print("New User Answer = \(userAnswer)")

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
                                ForEach (0..<questionRange.count, id: \.self) { index in
                                    Text("\(questionRange[index])")

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
                            TextField("Enter your answer", value: $userAnswer,
                                format: .number)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                    }
                }
                    Button("Submit")
                    {
                        rightAnswerStatus = checkAnswer(base: tableStart, multiplier: randNum, answer: userAnswer)
                       // animate for correct answer
                        if rightAnswerStatus {
                            score += 1
                        }


//      Release the keyboard
                        
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        addNewPrompt()
                    }
                    .bold()

                if !showStartPanel {
                    ZStack {
                        Circle()
                            .foregroundColor(.green)
                            .animation(.easeInOut(duration: 2), value: 1)
                        
                        Text("\(userAnswer ?? 0)")
                            .frame(width: 40, height: 40)
                    }
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

    }  // End of View
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
