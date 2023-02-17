//
//  ContentView.swift
//  WordScramble
//
//  Created by Mike Colvin on 2/5/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var userScore = 0
    @State private var lengthWord = 0
    
    var body: some View {
        NavigationStack
        {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }
                .padding()
                .padding()

                Section {
                    Button("Restart Game", action: restartGame)
                }

            }
            .onSubmit (addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }


            .navigationTitle(rootWord)
        }
        .toolbar(content:
        {
           ToolbarItem(placement: .bottomBar) {
               Text("Score: \(userScore)")
            }
        })

        
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isValid(word: answer) else {
            wordError(title: "Word not long or invalid", message: "Your word is too short - or is the same as the root word!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        lengthWord = newWord.count
        userScore = userScore + lengthWord
        print("Word length = \(lengthWord)")
        
        newWord = ""
        
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                userScore = userScore + lengthWord
                return
            }
        }
        
        fatalError("Couldn't load start.txt from bundle.")
    }
    
    func restartGame() {
        usedWords.removeAll()
        userScore = 0
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isValid(word: String) -> Bool {
        let checkWord = rootWord
        
        if  word == checkWord {
            return false
        }
        
        if word.count <= 3 {
            return false
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String)  {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
