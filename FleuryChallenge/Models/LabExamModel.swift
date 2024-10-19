import Foundation

struct LabExamResponse: Codable, Identifiable {
    let id: Int
    let name: String
    let doctor: String
    let timestamp: TimeInterval
    let healthy: Bool
}
