import Foundation

struct CutEntry: Identifiable, Codable, Equatable {
    let id: UUID
    var createdAt: Date
    var project: String
    var boardName: String
    var lengthIn: Double
    var widthIn: Double
    var thicknessIn: Double
    var cost: Double
    var notes: String

    init(
        id: UUID = UUID(),
        createdAt: Date = Date(),
        project: String = "",
        boardName: String = "",
        lengthIn: Double = 0,
        widthIn: Double = 0,
        thicknessIn: Double = 0,
        cost: Double = 0,
        notes: String = ""
    ) {
        self.id = id
        self.createdAt = createdAt
        self.project = project
        self.boardName = boardName
        self.lengthIn = lengthIn
        self.widthIn = widthIn
        self.thicknessIn = thicknessIn
        self.cost = cost
        self.notes = notes
    }
}
