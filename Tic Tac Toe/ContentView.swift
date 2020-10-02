//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Kadir Ince on 2.10.2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationTitle("Tic Tac Toe")
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    @State var moves: [String] = Array(repeating: "", count: 9)
    @State var isPlaying = true
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing: 15) {
                ForEach(0 ..< 9, id: \.self) { index in
                    ZStack {
                        Color.white

                        Text(moves[index])
                            .font(.system(size: 55))
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                    }
                    .frame(width: (screenWidth - 60)/3, height: (screenWidth - 60)/3)
                    .cornerRadius(15)
                    .onTapGesture(perform: {
                        withAnimation(.easeIn(duration: 0.5)) {
                            if moves[index] == "" {
                                moves[index] = isPlaying ? "X" : "O"
                                isPlaying.toggle()
                            }
                        }
                    })
                }
            }
            .padding()
        }
    }
}

let screenWidth = UIScreen.main.bounds.width
