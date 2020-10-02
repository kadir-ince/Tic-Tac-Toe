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
    @State var gameOver = false
    @State var showMessage = ""

    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing: 15) {
                ForEach(0 ..< 9, id: \.self) { index in
                    ZStack {
                        Color.blue

                        Color.white
                            .opacity(moves[index] == "" ? 1 : 0)

                        Text(moves[index])
                            .font(.system(size: 55))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                    }
                    .frame(width: (screenWidth - 60)/3, height: (screenWidth - 60)/3)
                    .cornerRadius(15)
                    .rotation3DEffect(
                        .init(degrees: moves[index] == "" ? 180 : 0),
                        axis: (x: 0.0, y: 1.0, z: 0.0),
                        anchor: .center,
                        anchorZ: 0.0,
                        perspective: 1.0
                    )
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
        .onChange(of: moves, perform: { _ in
            checkWinner()
        })
        .alert(isPresented: $gameOver, content: {
            Alert(title: Text("Result"), message: Text(showMessage), dismissButton: .destructive(Text("Play Again"), action: {
                withAnimation(.easeIn(duration: 0.5)) {
                    moves.removeAll()
                    moves = Array(repeating: "", count: 9)
                    isPlaying = true
                }
            }))
        })
    }

    func checkWinner() {
        if checkMoves(player: "X") {
            showMessage = "Player X Won 🎉"
            gameOver.toggle()
        }
        if checkMoves(player: "O") {
            showMessage = "Player O Won 🎉"
            gameOver.toggle()
        }

        // this if section is will update...
        if moves[0] != "", moves[1] != "", moves[2] != "", moves[3] != "", moves[4] != "", moves[5] != "", moves[6] != "", moves[7] != "", moves[8] != "" {
            showMessage = "Nobody Won ☹️"
            gameOver.toggle()
        }
        
    }

    func checkMoves(player: String) -> Bool {
        // horizontal check
        for i in stride(from: 0, to: 9, by: 3) {
            if moves[i] == player, moves[i+1] == player, moves[i+2] == player {
                return true
            }
        }

        // vertical check
        for i in 0 ... 2 {
            if moves[i] == player && moves[i+3] == player && moves[i+6] == player {
                return true
            }
        }

        // diagonal check

        if moves[0] == player && moves[4] == player && moves[8] == player {
            return true
        }
        else if moves[2] == player && moves[4] == player && moves[6] == player {
            return true
        }
        return false
    }
}

let screenWidth = UIScreen.main.bounds.width
