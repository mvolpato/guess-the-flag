//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Michele Volpato on 17/11/2020.
//

import SwiftUI

struct FlagImage: View {
    var country: String

    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""

    @State private var score = 0

    @State private var animationRotation = [0.0, 0.0, 0.0]
    @State private var animationOpacity = [1.0, 1.0, 1.0]

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]),
                           startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(country: self.countries[number])
                            .opacity(self.animationOpacity[number])
                            .rotation3DEffect(.degrees(animationRotation[number]), axis: (x: 0, y: 1, z: 0))
                    }
                }
                Text("Your score: \(score)")
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            withAnimation(.spring()) {
                self.animationRotation[number] += 360
                var newOpacities = [0.25, 0.25, 0.25]
                newOpacities[number] = 1.0
                self.animationOpacity = newOpacities
            }
        } else {
            scoreTitle = "Wrong. That’s the flag of \(countries[number])"
            score -= 1
        }

        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        animationOpacity = [1.0, 1.0, 1.0]
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
