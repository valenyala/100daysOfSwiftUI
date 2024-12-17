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
    
    // animation props
    @State private var rotationDegrees: [Double] = Array(repeating: 0.0, count: 3)
    @State private var opacities: [Double] = Array(repeating: 1.0, count: 3)
    
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
                    FlagImage(flagName: countries[number], number: number, flagTapped: flagTapped)
                        .rotation3DEffect(Angle(degrees: rotationDegrees[number]), axis: (0, 1, 0))
                        .opacity(opacities[number])
                    
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
    
    func showAnimation(tappedFlag: Int) {
        for i in 0...2 {
            if tappedFlag == i {
                withAnimation(.easeIn(duration: 1)) {
                    rotationDegrees[i] += 360
                }
            }
            else {
                withAnimation {
                    opacities[i] = 0.25
                }
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        
        showAnimation(tappedFlag: number)
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            resultText = "Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            
            resultText = "That's the flag of \(countries[number])"
        }
        
        round += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            showingScoreAlert = true
        }
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
        
        resetAnimation()
    }
    
    func resetAnimation() {
        opacities = Array(repeating: 1.0, count: 3)
    }
}

#Preview {
    ContentView()
}
