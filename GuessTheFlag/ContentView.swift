//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Hasan Kaya on 20.10.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["estonia", "france","germany","turkey","ireland","uk","us","spain","poland","nigeria","italy"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var isShowAlert = false
    @State private var scoreTitle = ""
    @State private var score = 0
    var body: some View {
        ZStack {
           RadialGradient(stops: [
            .init(color: Color(red: 0.1, green: 0.2, blue: 0.5 ), location: 0.3),
            .init(color: Color(red: 0.76, green: 0.2, blue: 0.26 ), location: 0.3)
           ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Text("Guess The Flag")
                    .foregroundColor(.white)
                    .font(.largeTitle.weight(.bold))
                    
                VStack (spacing: 30){
                    VStack {
                       
                        Text("Tap to flag of ")
                            .font(.headline.weight(.heavy))
                            .foregroundColor(.white)
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            // flags was tapped
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .resizable()
                                .aspectRatio(CGSize(width: 300, height: 200), contentMode: .fit)
                                .clipShape(Capsule())
                                .shadow(color: Color.black.opacity(0.7), radius: 5)
                                
                        }
                    }
                    
                }
                .frame(width: 400,height: 600)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                Text("Score : \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
            }
            
            
        }
        .alert(scoreTitle, isPresented: $isShowAlert) {
            Button("Continue", action: askQuestion)
        } message: {
             Text("Your Score Is : \(score)")
        }
       
    }
    func flagTapped(_ number : Int) {
        if number == correctAnswer {
            score+=1
            scoreTitle = "True"
        } else {
            scoreTitle = "Wrong"
        }
        isShowAlert = true
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
