//
//  LabExamCardView.swift
//  FleuryChallenge
//
//  Created by Brener Leite on 16/10/24.
//

import SwiftUI

struct LabExamCardView: View {
    let labExam: LabExamResponse
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            HStack {
                Text(labExam.name)
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                Image(systemName: labExam.healthy ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(labExam.healthy ? .green : .red)
                    .font(.title)
            }
                VStack(alignment: .leading) {
                    Text("Médico")
                    
                    HStack {
                        Text(labExam.doctor)
                            .font(.title3)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        
                        Spacer()
                        
                        Text(formattedDate(timestamp: labExam.timestamp))
                            .font(.title3)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                }
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5)
    }
    
    func formattedDate(timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: date)
    }
}

#Preview {
    HStack {
        LabExamCardView(labExam: LabExamResponse(id: 1, name: "Hemograma, sangue total", doctor: "Morgan Freeman", timestamp: 1728345600, healthy: true))
    }
    .padding()
}
