
import Foundation
import Combine

struct OptimizationTask: Identifiable {

    let id = UUID()
    let title: String
    let description: String
    let symbol: String
}

final class OptimizationService: ObservableObject {

    @Published var completed: Set<String> = []

    let tasks = [

        OptimizationTask(
            title: "Close unnecessary apps",
            description: "Manually close apps you don't need.",
            symbol: "xmark.app"
        ),

        OptimizationTask(
            title: "Check thermal status",
            description: "Avoid gaming when the iPad is overheating.",
            symbol: "thermometer"
        ),

        OptimizationTask(
            title: "Check storage",
            description: "Keep sufficient free storage available.",
            symbol: "internaldrive"
        ),

        OptimizationTask(
            title: "Check network",
            description: "Use a stable Wi-Fi connection.",
            symbol: "wifi"
        ),

        OptimizationTask(
            title: "Check Low Power Mode",
            description: "Consider turning it off for demanding games.",
            symbol: "battery.100"
        )
    ]

    func toggle(_ task: OptimizationTask) {

        if completed.contains(task.title) {
            completed.remove(task.title)
        } else {
            completed.insert(task.title)
        }
    }

    var progress: Double {

        guard !tasks.isEmpty else {
            return 0
        }

        return Double(completed.count) /
               Double(tasks.count)
    }
}
