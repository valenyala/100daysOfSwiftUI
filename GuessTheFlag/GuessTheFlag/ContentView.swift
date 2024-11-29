//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Valentin Yang on 28/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScoreAlert = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var resultText = ""
    @State private var round = 1
    @State private var gameFinished = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 0)
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScoreAlert) {
            Button("Continue") {
                next()
            }
        } message: {
            Text(resultText)
        }
        .alert("Game finished", isPresented: $gameFinished) {
            Button("Start again") {
                retry()
            }
        } message: {
            Text("Your final score is: \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            resultText = "Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            
            resultText = "That's the flag of \(countries[number])"
        }
        
        round += 1
        showingScoreAlert = true
    }
    
    func retry() {
        round = 1
        score = 0
        
        next()
    }
    
    func next() {
        if round > 3 {
            gameFinished = true
        }
        else {
            countries.shuffle()
            
            correctAnswer = Int.random(in: 0...2)
        }
    }
}

#Preview {
    ContentView()
}
