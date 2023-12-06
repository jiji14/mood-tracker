//
//  WelcomeView.swift
//  MoodTracker
//
//  Created by Jijeong Lee on 12/4/23.
//


import SwiftUI
import FirebaseFirestore

struct WelcomeView: View {
    @State private var name: String = ""
    @Binding var userName: String
    let db = Firestore.firestore()
    
    var body: some View {
        VStack {
            Text("Welcome to Mood Tracker :D")
                .font(.title)
                .foregroundColor(.blue)
                .padding(.top, 60)
                .multilineTextAlignment(.leading)
            
            Text("Capture and track your daily mood effortlessly, gaining insights into your emotional journey.")
                .font(.title2)
                .padding(.top, 40)
            
            TextField("Enter your name", text: $name)
                  .padding(10)
                  .border(Color.gray, width: 1)
                  .padding(.top, 40)
            
            Button("Start") {
                    let usersCollection = db.collection("users")
                    usersCollection.addDocument(data: [
                            "name": name
                    ]) { error in
                        if let error = error {
                            print("Error adding document: \(error)")
                        } else {
                            print("Document added successfully")
                            userName = name
                        }
                    }
                }
                .padding()
                .frame(width: 200)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                .padding(.top, 40)
            
            Spacer()
        }
    }
}


