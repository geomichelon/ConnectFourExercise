//
//  ContentView.swift
//  ConnectFourGame
//
//  Created by George Michelon on 02/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("win") var win = 0
    @AppStorage("lose") var lose = 0
    @AppStorage("tie") var tie = 0
    
    @AppStorage("playerPiecesColor") var currentUserColor = Color.red
    @AppStorage("anotheruSerColor") var otherUserColor = Color.yellow
    // setting the values for the game
    // we can create a interface later to input this values
    @State private var currentUser = 21
    @State private var anotherUser = 21
    // setting the values based in current user and another user
    @State private var hole = Array(repeating: AreaGame.blank, count: 42)
    @State private var turn = Turn.user
    @State private var connectedArray: [Int] = []
    @State private var selectTab = 0
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    HStack {
                        Circle()
                            .frame(width: geometry.size.width / 9, height: geometry.size.width / 9)
                            .foregroundColor(currentUserColor)
                        
                        VStack {
                            HStack {
                                Text("You")
                                Spacer()
                                Text("Another user:")
                            }
                            .font(.title3.bold())
                            
                            HStack {
                                Text("\(currentUser)")
                                Spacer()
                                Text("vs")
                                Spacer()
                                Text("\(anotherUser)")
                            }
                        }
                        
                        Circle()
                            .frame(width: geometry.size.width / 9, height: geometry.size.width / 9)
                            .foregroundColor(otherUserColor)
                    }
                    
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                        ForEach(0..<42) { index in
                            switch hole[index] {
                            case .blank:
                                Circle()
                                    .frame(width: geometry.size.width / 9, height: geometry.size.width / 9)
                                    .foregroundColor(.black.opacity(0.5))
                                    .onTapGesture {
                                        if turn == .user {
                                            playerTurn(index: index)
                                        }
                                    }
                               // create de pins for current user
                            case .user:
                                if connectedArray.contains(index) {
                                    Circle()
                                        .strokeBorder(Color.white, lineWidth: 4)
                                        .background(Circle().fill(currentUserColor))
                                        .frame(width: geometry.size.width / 9, height: geometry.size.width / 9)
                                } else {
                                    Circle()
                                        .frame(width: geometry.size.width / 9, height: geometry.size.width / 9)
                                        .foregroundColor(currentUserColor)
                                        .onTapGesture {
                                            if turn == .user && hole[index % 7] == .blank {
                                               playerTurn(index: index)
                                            }
                                        }
                                }
                            // create the pins and actions for the another user
                            case .anotherUser:
                                if connectedArray.contains(index) {
                                    Circle()
                                        .strokeBorder(Color.white, lineWidth: 4)
                                        .background(Circle()
                                            .fill(otherUserColor))
                                        .frame(width: geometry.size.width / 9, height: geometry.size.width / 9)
                                } else {
                                    Circle()
                                        .frame(width: geometry.size.width / 9, height: geometry.size.width / 9)
                                        .foregroundColor(otherUserColor)
                                        .onTapGesture {
                                            if turn == .user && hole[index % 7] == .blank {
                                                playerTurn(index: index)
                                            }
                                        }
                                }
                            }
                            
                        }
                    }
                    .padding()
                    .background(.blue.opacity(0.6))
                    .cornerRadius(15)
                    .padding(.bottom, 10)
                    // validate each moviment in the square
                    let extractedExpr: some View = HStack {
                        Spacer()
                        switch turn {
                        case .user:
                            Text("Your Turn")
                                .bold()
                                .font(.title)
                        case .another:
                            Text("Another user Turn")
                                .bold()
                                .font(.title)
                        case .currentUserWin:
                            Text("*** You Won! ***")
                                .bold()
                                .font(.title)
                        case .anotherUserWin:
                            Text("*** Other user  Won! ***")
                                .bold()
                                .font(.title)
                        case .tie:
                            Text("There was a tie.")
                                .bold()
                                .font(.title)
                            
                        }
                        Spacer()
                    }
                        .padding(8)
                        .background(.blue.opacity(0.7))
                        .cornerRadius(15)
                        .padding(.bottom, 10)
                    extractedExpr
                    
                    if (turn != .user && turn != .another) {
                        HStack {
                            Spacer()
                            Button {
                                currentUser = 21
                                anotherUser = 21
                                hole = Array(repeating: .blank, count: 42)
                                turn = .user
                                connectedArray = []
                            } label: {
                                Text("New Game!")
                                    .bold()
                                    .font(.title)
                            }
                            Spacer()
                        }
                        .padding(8)
                        .background(.blue.opacity(0.7))
                        .cornerRadius(15)
                    }
                    Spacer()
                }
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Connect 4")
                            .bold()
                            .font(.largeTitle)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button {
                                if(turn != .another) {
                                    currentUser = 21
                                    anotherUser = 21
                                    hole = Array(repeating: .blank, count: 42)
                                    turn = .user
                                    connectedArray = []
                                }
                            } label: {
                                Image(systemName: "arrow.counterclockwise.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width / 15, height: geometry.size.width / 15)
                                    .padding(8.5)
                                    .background(.quaternary)
                                    .cornerRadius(15)
                            }
                            
                            NavigationLink {
                                SettingsView()
                            } label: {
                                Image(systemName: "gear")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width / 15, height: geometry.size.width / 15)
                                    .padding(8.5)
                                    .background(.quaternary)
                                    .cornerRadius(15)
                            }
                        }
                    }
                }
            }
        }
    }
    /*
     
     The playerTurn(index: Int) function has a time complexity of O(n) where n is the value of blankNum. The function iterates blankNum + 1 times with a time complexity of O(1) for each iteration. Therefore, the overall time complexity of the function is O(n).
     */
    func playerTurn(index: Int) {
        turn = .another
        currentUser -= 1
        var maxIndex = index % 7
        var blankNum = 0
        while (hole[maxIndex] == .blank && maxIndex+7 <= 41 && hole[maxIndex+7] == .blank) {
            blankNum += 1
            maxIndex += 7
        }
        var idx = index % 7
        for i in 0...blankNum {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12*Double(i)) {
                if(idx>6) {
                    self.hole[idx-7] = .blank
                }
                self.hole[idx] = .user
                idx += 7
                if(i == blankNum) {
                    checkFinish()
                    if(turn == .another) {
                        anotherUserTurn()
                    }
                }
            }
        }
    }
    // check if is ther other user turn
   /* The anotherUserTurn() function has a time complexity of O(1) for each of the five checks that it performs in the nested for loops. Therefore, the overall time complexity of the function is O(1).
    */
    func anotherUserTurn() {
        anotherUser -= 1
        // check "|"
        for row in 0...2 {
            for col in 0...6 {
                // verify if is in the limit of array
                if (self.hole[7*row+col] == .blank
                    && self.hole[7*row+col+7] != .blank
                    && self.hole[7*row+col+7] == self.hole[7*row+col+14]
                    && self.hole[7*row+col+14] == self.hole[7*row+col+21]) {
                    anotherUSerDrop(col: col, row: row)
                    return
                }
            }
        }
        // check "\" and drop at left
        for row in 0...2 {
            for col in 0...3 {
                if (self.hole[7*row+col] == .blank
                    && self.hole[7*row+col+7] != .blank
                    && self.hole[7*row+col+8] != .blank
                    && self.hole[7*row+col+8] == self.hole[7*row+col+16]
                    && self.hole[7*row+col+16] == self.hole[7*row+col+24]) {
                    anotherUSerDrop(col: col, row: row)
                    return
                }
            }
        }
        // check "\" and drop at right
        for row in 0...2 {
            for col in 0...3 {
                if (self.hole[7*row+col] != .blank
                    && self.hole[7*row+col] == self.hole[7*row+col+8]
                    && self.hole[7*row+col+8] == self.hole[7*row+col+16]
                    && self.hole[7*row+col+24] == .blank) {
                    if(7*row+col+31<=41 && self.hole[7*row+col+31] != .blank) {
                        anotherUSerDrop(col: col+24, row: row+3)
                        return
                    } else if(7*row+col+31>41) {
                        anotherUSerDrop(col: col+24, row: row+3)
                        return
                    }
                }
            }
        }
        // check "/" and drop at left
        for row in 0...2 {
            for col in 3...6 {
                if (self.hole[7*row+col] != .blank
                    && self.hole[7*row+col] == self.hole[7*row+col+6]
                    && self.hole[7*row+col+6] == self.hole[7*row+col+12]
                    && self.hole[7*row+col+18] == .blank) {
                    if(7*row+col+25<=41 && self.hole[7*row+col+25] != .blank) {
                        anotherUSerDrop(col: col+18, row: row+3)
                        return
                    } else if(7*row+col+25>41) {
                        anotherUSerDrop(col: col+18, row: row+3)
                        return
                    }
                }
            }
        }
        // check "/" and drop at right
        for row in 0...2 {
            for col in 3...6 {
                if (self.hole[7*row+col] == .blank
                    && self.hole[7*row+col+6] != .blank
                    && self.hole[7*row+col+7] != .blank
                    && self.hole[7*row+col+6] == self.hole[7*row+col+12]
                    && self.hole[7*row+col+12] == self.hole[7*row+col+18]) {
                    anotherUSerDrop(col: col, row: row)
                    return
                }
            }
        }
        // check "-" and drop at left to win
        for row in 0...5 {
            for col in 0...3 {
                if (self.hole[7*row+col] == .blank
                    && self.hole[7*row+col+1] == .anotherUser
                    && self.hole[7*row+col+1] == self.hole[7*row+col+2]
                    && self.hole[7*row+col+2] == self.hole[7*row+col+3]) {
                    if(7*row+col+7<=41 && self.hole[7*row+col+7] != .blank) {
                        anotherUSerDrop(col: col, row: row)
                        return
                    } else if(7*row+col+7>41) {
                        anotherUSerDrop(col: col, row: row)
                        return
                    }
                }
            }
        }
        // check "-" and drop at right to win
        for row in 0...5 {
            for col in 3...6 {
                if (self.hole[7*row+col] == .blank
                    && self.hole[7*row+col-1] == .anotherUser
                    && self.hole[7*row+col-1] == self.hole[7*row+col-2]
                    && self.hole[7*row+col-2] == self.hole[7*row+col-3]) {
                    if(7*row+col+7<=41 && self.hole[7*row+col+7] != .blank) {
                        anotherUSerDrop(col: col, row: row)
                        return
                    } else if(7*row+col+7>41) {
                        anotherUSerDrop(col: col, row: row)
                        return
                    }
                }
            }
        }
        // check "-" and drop at left to prevent user win
        for row in 0...5 {
            for col in 0...4 {
                if (self.hole[7*row+col] == .blank
                    && self.hole[7*row+col+1] == .user
                    && self.hole[7*row+col+1] == self.hole[7*row+col+2]) {
                    if(7*row+col+7<=41 && self.hole[7*row+col+7] != .blank) {
                        anotherUSerDrop(col: col, row: row)
                        return
                    } else if(7*row+col+7>41) {
                        anotherUSerDrop(col: col, row: row)
                        return
                    }
                }
            }
        }
        // check "-" and drop at right to prevent user win
        for row in 0...5 {
            for col in 2...6 {
                if (self.hole[7*row+col] == .blank
                    && self.hole[7*row+col-1] == .user
                    && self.hole[7*row+col-1] == self.hole[7*row+col-2]) {
                    if(7*row+col+7<=41 && self.hole[7*row+col+7] != .blank) {
                        anotherUSerDrop(col: col, row: row)
                        return
                    } else if(7*row+col+7>41) {
                        anotherUSerDrop(col: col, row: row)
                        return
                    }
                }
            }
        }
        
        var col = Int.random(in: 0...6)
        while (self.hole[col] != .blank) {
            col = Int.random(in: 0...6)
        }
        var blankNum = 0
        while (hole[col] == .blank && col+7 <= 41 && hole[col+7] == .blank) {
            blankNum += 1
            col += 7
        }
        anotherUSerDrop(col: col, row: blankNum)
    }
    // Verifying the current position
    //of the pin and if who wins
    func anotherUSerDrop(col: Int, row: Int) {
        var idx = col % 7
        for i in 0...row {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12*Double(i)) {
                if(idx>6) {
                    self.hole[idx-7] = .blank
                }
                self.hole[idx] = .anotherUser
                idx += 7
                if(i == row) {
                    checkFinish()
                    if(turn == .another) {
                        if(anotherUser == 0) {
                            turn = .tie
                            tie += 1
                        } else {
                            turn = .user
                        }
                    }
                }
            }
        }
    }
    
        
    func checkFinish() {
        // check "|"
        //This loop checks for a vertical win, and it runs for 6 rows and 7 columns. Therefore, the time complexity is  O(1).
        for row in 0...2 {
            for col in 0...6 {
                if (self.hole[7*row+col] != .blank
                    && self.hole[7*row+col] == self.hole[7*row+col+7]
                    && self.hole[7*row+col+7] == self.hole[7*row+col+14]
                    && self.hole[7*row+col+14] == self.hole[7*row+col+21]) {
                    connectedArray.append(7*row+col)
                    connectedArray.append(7*row+col+7)
                    connectedArray.append(7*row+col+14)
                    connectedArray.append(7*row+col+21)
                    if(self.hole[7*row+col] == .user) {
                        turn = .currentUserWin
                        win += 1
                    } else {
                        turn = .anotherUserWin
                        lose += 1
                    }
                    return
                }
            }
        }
        // check "-"
       //  This loop checks for a horizontal win, and it runs for 6 rows and 4 columns. Therefore, the time complexity is  O(1).
        for row in 0...5 {
            for col in 0...3 {
                if (self.hole[7*row+col] != .blank
                    && self.hole[7*row+col] == self.hole[7*row+col+1]
                    && self.hole[7*row+col+1] == self.hole[7*row+col+2]
                    && self.hole[7*row+col+2] == self.hole[7*row+col+3]) {
                    connectedArray.append(7*row+col)
                    connectedArray.append(7*row+col+1)
                    connectedArray.append(7*row+col+2)
                    connectedArray.append(7*row+col+3)
                    if(self.hole[7*row+col] == .user) {
                        turn = .currentUserWin
                        win += 1
                    } else {
                        turn = .anotherUserWin
                        lose += 1
                    }
                    return
                }
            }
        }
        // check "\"
      //  This loop checks for a diagonal win from top left to bottom right, and it runs for 3 rows and 4 columns. Therefore, the time complexity is  O(1).
        
        for row in 0...2 {
            for col in 0...3 {
                if (self.hole[7*row+col] != .blank
                    && self.hole[7*row+col] == self.hole[7*row+col+8]
                    && self.hole[7*row+col+8] == self.hole[7*row+col+16]
                    && self.hole[7*row+col+16] == self.hole[7*row+col+24]) {
                    connectedArray.append(7*row+col)
                    connectedArray.append(7*row+col+8)
                    connectedArray.append(7*row+col+16)
                    connectedArray.append(7*row+col+24)
                    if(self.hole[7*row+col] == .user) {
                        turn = .currentUserWin
                        win += 1
                    } else {
                        turn = .anotherUserWin
                        lose += 1
                    }
                    return
                }
            }
        }
        // check "/"
        // This loop checks for a diagonal win from top right to bottom left, and it runs for 3 rows and 4 columns. Therefore, the time complexity is  O(1).
        for row in 0...2 {
            for col in 3...6 {
                if (self.hole[7*row+col] != .blank
                    && self.hole[7*row+col] == self.hole[7*row+col+6]
                    && self.hole[7*row+col+6] == self.hole[7*row+col+12]
                    && self.hole[7*row+col+12] == self.hole[7*row+col+18]) {
                    connectedArray.append(7*row+col)
                    connectedArray.append(7*row+col+6)
                    connectedArray.append(7*row+col+12)
                    connectedArray.append(7*row+col+18)
                    if(self.hole[7*row+col] == .user) {
                        turn = .currentUserWin
                        win += 1
                    } else {
                        turn = .anotherUserWin
                        lose += 1
                    }
                    return
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
