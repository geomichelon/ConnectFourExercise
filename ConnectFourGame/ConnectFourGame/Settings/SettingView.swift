//
//  SettingView.swift
//  ConnectFourGame
//
//  Created by George Michelon on 02/03/23.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("win") var win = 0
    @AppStorage("lose") var lose = 0
    @AppStorage("tie") var tie = 0
    
    @AppStorage("playerPiecesColor") var playerColor = Color.red
    @AppStorage("anotheruSerColor") var anotherUserColor = Color.yellow
    
    var body: some View {
        List {
            Section(header: Text("Piece Color")) {
                ColorPicker("Player  Color", selection: $playerColor)
                ColorPicker("Another user  Color", selection: $anotherUserColor)
            }
            
            Section(header: Text("Current Score")) {
                Text("Total Wins: \(win)")
                Text("Total Lost: \(lose)")
                Text("Total Tie: \(tie)")
            }
            
            Section(header: Text("Reset Score")) {
                Button {
                    win = 0
                    lose = 0
                    tie = 0
                } label: {
                    HStack {
                        Text("Clear Score Data")
                            Spacer()
                        Image(systemName: "arrow.triangle.2.circlepath.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.black)
                            .frame(width: 25, height: 25)
                    }
                }
            }
            Section(header: Text("Version: 1.0.0")) {}
        }
        .listStyle(.grouped)
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

