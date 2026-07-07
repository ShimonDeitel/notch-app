import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [CutEntry] = []
    @Published var isPro: Bool = false

    static let freeLimit = 8

    private let fileURL: URL = {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir.appendingPathComponent("notch_items.json")
    }()

    init() {
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: CutEntry) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: CutEntry) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: CutEntry) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([CutEntry].self, from: data) {
            items = decoded
        } else {
            items = Store.seedData
        }
    }

    func save() {
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: fileURL, options: .atomic)
        }
    }

    static let seedData: [CutEntry] = [
        CutEntry(project: "Project 1", boardName: "Boardname 1", lengthIn: 10.0, widthIn: 10.0, thicknessIn: 10.0, cost: 10.0, notes: "Notes 1"),
        CutEntry(project: "Project 2", boardName: "Boardname 2", lengthIn: 20.0, widthIn: 20.0, thicknessIn: 20.0, cost: 20.0, notes: "Notes 2"),
        CutEntry(project: "Project 3", boardName: "Boardname 3", lengthIn: 30.0, widthIn: 30.0, thicknessIn: 30.0, cost: 30.0, notes: "Notes 3")
    ]
}
