//
//  RecordView.swift
//  MoodTracker
//
//  Created by Jijeong Lee on 12/4/23.
//

import SwiftUI
import FirebaseFirestore

struct RecordView: View {
    @State private var selectedDate = Date()
    @Binding var userName: String
    let db = Firestore.firestore()
    @State private var moodData: [MoodModel] = []
    
    var body: some View {
        VStack {
            Text("Record")
                .font(.title)
                .padding(.top, 10)
                .multilineTextAlignment(.leading)
            
            DatePicker("Select a date", selection: $selectedDate, displayedComponents: [.date])
                   .datePickerStyle(GraphicalDatePickerStyle())
                   .labelsHidden()
                   .padding()
                   .onChange(of: selectedDate) { newDate in
                        print("Selected date changed to: \(newDate)")
                       let moodsCollection = db.collection("moods")
                       let dateFormatter = DateFormatter()
                       dateFormatter.dateFormat = "yyyy-MM-dd"
                       let formattedDate = dateFormatter.string(from: newDate)
                       
                       moodsCollection
                           .whereField("name", isEqualTo: userName)
                           .whereField("date", isEqualTo: formattedDate)
                           .getDocuments { (querySnapshot, error) in
                               if let error = error {
                                   print("Error getting documents: \(error)")
                               } else {
                                   var moodList: [MoodModel] = []
                                      for document in querySnapshot!.documents {
                                          print(document.data())
                                          var tempData = document.data()
                                          tempData["id"] = document.documentID // Assign document ID to the "id" key
                                          if let moodData = MoodModel(tempData) {
                                              moodList.append(moodData)
                                          }
                                      }
                                      self.moodData = moodList
                               }
                           }
                    }

            if let formattedDate = formatDate(selectedDate) {
                Text("\(formattedDate) Mood Diary")
                    .foregroundColor(.blue)
                    
                    .font(.title2)
                    .padding(.top, 10)
            }
            
            List(moodData, id: \.id) { mood in
                VStack(alignment: .leading) {
                    HStack{
                        Text("Mood: \(mood.mood)")
                        Text("Rate: \(mood.rate) / 5")
                        
                        Spacer() // Add spacer to push the button to the right
                        
                        Button(action: {
                            deleteMood(mood)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }

                }
            }
            Spacer()
        }
    }
    
    private func deleteMood(_ mood: MoodModel) {
        let moodsCollection = db.collection("moods")
        moodsCollection.document(mood.id).delete { error in
            if let error = error {
                print("Error deleting document: \(error)")
            } else {
                print("Document deleted successfully")
                // Remove the deleted mood from the local array
                self.moodData.removeAll { $0.id == mood.id }
            }
        }
    }
}

private func formatDate(_ date: Date) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM d, yyyy"
    return dateFormatter.string(from: date)
}
