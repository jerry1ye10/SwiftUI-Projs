//
//  ContentView.swift
//  App2
//
//  Created by Jerry Ye on 4/20/20.
//  Copyright © 2020 Jerry Ye. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var previousGuess = 0
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
        VStack(spacing: 30){
            VStack {
                Text("Tap the flag of")
                Text(countries[correctAnswer])
            }
        ForEach(0 ..< 3) { number in
            Button(action: {
                self.flagTapped(number)
            }) {
                Image(self.countries[number])
                    .renderingMode(.original)
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                    .shadow(color: .black, radius: 2)
                
            }
        }
            Text("Current Score: \(score)")

            Spacer()
        }
            

        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your guess of \(countries[previousGuess]) was. Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
        
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score = score + 1
        } else {
            scoreTitle = "Wrong"
            score = score - 1
        }
        previousGuess = number

        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
