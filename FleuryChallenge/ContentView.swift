import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LabExamListViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading, spacing: 20) {
                    if viewModel.isLoading {
                        ProgressView("Carregando exames...")
                            .padding()
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        ForEach(searchResults) { labExam in
                            LabExamCardView(labExam: labExam)
                        }
                    }
                }
                .searchable(text: $searchText)
                .navigationTitle("Desafio Fleury")
                .padding(.horizontal)
                .task {
                    await viewModel.fetchLabExams()
                }
            }
        }
    }

    private var searchResults: [LabExamResponse] {
        if searchText.isEmpty {
            return viewModel.labExams
        } else {
            return viewModel.labExams.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.doctor.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

#Preview {
    ContentView()
}
