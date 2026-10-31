
import Foundation
import Combine

final class ThermalMonitor: ObservableObject {

    @Published var status = "Normal"

    init() {
        update()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(update),
            name: ProcessInfo.thermalStateDidChangeNotification,
            object: nil
        )
    }

    @objc func update() {

        let state = ProcessInfo.processInfo.thermalState

        DispatchQueue.main.async {

            switch state {

            case .nominal:
                self.status = "Normal"

            case .fair:
                self.status = "Fair"

            case .serious:
                self.status = "High"

            case .critical:
                self.status = "Critical"

            @unknown default:
                self.status = "Unknown"
            }
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
