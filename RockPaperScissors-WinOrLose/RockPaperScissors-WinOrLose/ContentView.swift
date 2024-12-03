//
//  ContentView.swift
//  RockPaperScissors-WinOrLose
//
//  Created by Valentin Yang on 2/12/24.
//

import SwiftUI

struct ContentView: View {
    let possibleMoves: [String] = ["✊🏻", "🖐🏻", "✌🏻"]
    
    @State private var round = 1
    @State private var computerMove = Int.random(in: 0...2)
    @State private var userHaveToWin = Bool.random()
    @State private var score = 0
    @State private var showRoundResultAlert = false
    @State private var resultCorrect: Bool = false
    @State private var gameFinished: Bool = false
    var txtUserHaveToWin: String {
        return userHaveToWin ? "win" : "lose"
    }
    
    var body: some View {
        ZStack {
            Color(hex: "121A21")
                .ignoresSafeArea()
            VStack(spacing: 30) {
                Spacer().frame(height: 52)
                Text("Rock, Paper, Scissors")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Round \(round)")
                    .font(.title2)
                
                HStack {
                    Text("Try to")
                    Text(txtUserHaveToWin)
                        .fontWeight(.bold)
                        .foregroundStyle(userHaveToWin ? Color.green : Color.red)
                    Text("against:")
                }
                .foregroundStyle(.secondary)
                .font(.title)
                
                Text(possibleMoves[computerMove])
                    .font(.system(size: 180))
                
                Text("Your Choice:")
                    .font(.title2)
                    .fontWeight(.bold)
                
                HStack {
                    ForEach(0..<possibleMoves.count) { index in
                        let text = getTextFromMove(of: index)
                        BaseButton(text: text, move: index) { num in
                            if userHaveToWin {
                                resultCorrect = checkIfWon(with: num)
                            } else {
                                resultCorrect = checkIfLose(with: num)
                            }
                            
                            if resultCorrect {
                                score += 1
                            }
                            
                            showRoundResultAlert = true
                        }
                    }
                }
                .alert("Result", isPresented: $showRoundResultAlert) {
                    Button("Next") {
                        shuffle()
                    }
                } message: {
                    Text(resultCorrect ? "Correct!" : "Wrong!")
                }
                .alert("Game Finished", isPresented: $gameFinished) {
                    Button("Restart") {
                        restart()
                    }
                } message: {
                    Text("Your score is \(score)")
                }
                Spacer()
                
            }
            .white()
        }
    }
    
    func shuffle() {
        if round <= 4 {
            computerMove = Int.random(in: 0..<3)
            userHaveToWin = Bool.random()
            round += 1
        }
        else {
            gameFinished = true
        }
    }
    
    func restart() {
        round = 0
        score = 0
        shuffle()
    }

    func checkIfWon(with userMove: Int) -> Bool {
        return userMove == (computerMove + 1) % 3
    }
    
    func checkIfLose(with userMove: Int) -> Bool {
        return userMove == (computerMove + 2) % 3
    }
    
    func getTextFromMove(of move: Int) -> String {
        switch move {
        case 1:
            return "\(possibleMoves[1]) Paper"
        case 2:
            return "\(possibleMoves[2]) Scissor"
        default:
            return "\(possibleMoves[0]) Rock"
        }
    }
}

extension View {
    func white() -> some View{
        self.foregroundStyle(.white)
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0
        
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }
        
        if scanner.scanHexInt64(&hexNumber) {
            let r = Double((hexNumber & 0xFF0000) >> 16) / 255.0
            let g = Double((hexNumber & 0x00FF00) >> 8) / 255.0
            let b = Double(hexNumber & 0x0000FF) / 255.0
            let a = Double((hexNumber & 0xFF000000) >> 24) / 255.0
            
            self = Color(red: r, green: g, blue: b, opacity: a > 0 ? a : 1.0)
            return
        }
        
        self = Color.red // Default fallback
    }
}

#Preview {
    ContentView()
}
