//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Michele Volpato on 17/11/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .red]), startPoint: .top, endPoint: .bottom)
            VStack {
                Button("Show Alert") {
                    self.showingAlert = true
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Hello SwiftUI!"), message: Text("This is some detail message"), dismissButton: .default(Text("OK")))
                }
                ForEach(0..<3) {_ in
                    HStack {
                        ForEach(0..<3) {_ in
                            Text("X")
                        }
                    }
                }
                Button("Tap me!") {
                    print("Button was tapped")
                }
                Button(action: {
                    print("Edit button was tapped")
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "pencil")
                        Text("Edit")
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
