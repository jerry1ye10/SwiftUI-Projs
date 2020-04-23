//
//  ContentView.swift
//  app3
//
//  Created by Jerry Ye on 4/21/20.
//  Copyright © 2020 Jerry Ye. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var b = false
    var body: some View {
        HStack{
            if b {
            Text("Hello World")
            } else {
                Text("Hello World")
                    .background(Color.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
