//
//  CheckInView.swift
//  MoodTracker
//
//  Created by Jijeong Lee on 12/4/23.
//

import SwiftUI
import FirebaseFirestore

struct CheckInView: View {
    @State private var moodText: String = ""
    @State private var selectedRating: Int = 3
    @Binding var userName: String
    let db = Firestore.firestore()
    
    struct HeartRatingView: View {
        @Binding var moodRating: Int
        var body: some View {
            HStack {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= moodRating ? "heart.fill" : "heart")
                        .foregroundColor(.pink)
                        .font(.system(size: 40))
                        .frame(width: 50)
                        .onTapGesture {
                            moodRating = index
                        }
                }
            }
            .padding()
        }
    }
    
    var body: some View {
        VStack {
            Text("Check-In")
                .font(.title)
                .padding(.top, 10)
                .multilineTextAlignment(.leading)
            
            Text("Record your daily mood :)")
                .font(.title2)
                .padding(.top, 10)
            
            TextField("Enter your mood here", text: $moodText)
                  .padding(10)
                  .frame(minHeight: 200)
    
                  .border(Color.gray, width: 1)
                  .padding(.top, 20)
            Text("Rate your mood level :)")
                .font(.title2)
                .padding(.top, 30)
            
            HeartRatingView(moodRating: $selectedRating)
            
            Button("Submit") {
                    print("Mood submitted: \(moodText), rate: \(selectedRating), \(userName)")
                let moodsCollection = db.collection("moods")
                let currentDate = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let formattedDate = dateFormatter.string(from: currentDate)
                
                moodsCollection.addDocument(data: [
                        "name": userName,
                        "mood": moodText,
                        "rate": selectedRating,
                        "date": formattedDate
                    ]) { error in
                        if let error = error {
                            print("Error adding document: \(error)")
                        } else {
                            print("Document added successfully")
                            moodText = ""
                            selectedRating = 3
                        }
                    }
                }
                .padding()
                .frame(width: 200)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                .padding(.top, 20)
            
            Spacer()
        }
    }
}

