import Foundation
import Combine

class LabExamListViewModel: ObservableObject {
    @Published var labExams: [LabExamResponse] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchLabExams() async {
        guard let url = URL(string: "https://5bfbefa5cf9d29001345c529.mockapi.io/api/v1/results/") else {
            DispatchQueue.main.async {
                self.errorMessage = "Invalid URL"
            }
            return
        }
        
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let decodedExams = try JSONDecoder().decode([LabExamResponse].self, from: data)
            
            DispatchQueue.main.async {
                self.labExams = decodedExams
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
