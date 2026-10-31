
import Foundation
import Combine
import MachO

final class MemoryMonitor: ObservableObject {

    @Published var usedMemoryMB: Double = 0

    func refresh() {

        var info = task_vm_info_data_t()

        var count = mach_msg_type_number_t(
            MemoryLayout<task_vm_info_data_t>.size /
            MemoryLayout<integer_t>.size
        )

        let result = withUnsafeMutablePointer(to: &info) {
            pointer in

            pointer.withMemoryRebound(
                to: integer_t.self,
                capacity: Int(count)
            ) {
                task_info(
                    mach_task_self_,
                    task_flavor_t(TASK_VM_INFO),
                    $0,
                    &count
                )
            }
        }

        if result == KERN_SUCCESS {

            let memory = Double(info.phys_footprint) / 1_048_576

            DispatchQueue.main.async {
                self.usedMemoryMB = memory
            }
        }
    }
}
