//
//  ContentView.swift
//  MoodTracker
//
//  Created by Jijeong Lee on 12/4/23.
//
import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    @State private var userName: String = ""
    let db = Firestore.firestore()
    
    var body: some View {
        if userName == "" {
            WelcomeView(userName: $userName)
        } else {
            // Show TabView with CheckInView and RecordView otherwise
            TabView {
                // First Tab
                CheckInView(userName: $userName)
                    .tabItem {
                        Label("Check-In", systemImage: "highlighter")
                    }

                // Second Tab
                RecordView(userName: $userName)
                    .tabItem {
                        Label("Record", systemImage: "calendar")
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
