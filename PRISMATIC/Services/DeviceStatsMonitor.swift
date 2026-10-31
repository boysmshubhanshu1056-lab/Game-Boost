
import Foundation
import Combine
import Darwin
import MachO

final class DeviceStatsMonitor: ObservableObject {

    @Published var totalRAMGB: Double?
    @Published var usedRAMGB: Double?
    @Published var availableRAMGB: Double?

    @Published var totalStorageGB: Double?
    @Published var usedStorageGB: Double?
    @Published var availableStorageGB: Double?

    @Published var lastUpdated: Date?
    @Published var errorMessage: String?

    func refresh() {
        refreshRAM()
        refreshStorage()
        lastUpdated = Date()
    }

    private func refreshRAM() {
        var totalBytes: UInt64 = 0
        var totalSize = MemoryLayout<UInt64>.size

        let totalResult = sysctlbyname(
            "hw.memsize",
            &totalBytes,
            &totalSize,
            nil,
            0
        )

        guard totalResult == 0, totalBytes > 0 else {
            totalRAMGB = nil
            usedRAMGB = nil
            availableRAMGB = nil
            errorMessage = "System RAM information is unavailable."
            return
        }

        var statistics = vm_statistics64_data_t()
        var count = mach_msg_type_number_t(
            MemoryLayout<vm_statistics64_data_t>.size /
            MemoryLayout<integer_t>.size
        )

        let result = withUnsafeMutablePointer(to: &statistics) { pointer in
            pointer.withMemoryRebound(
                to: integer_t.self,
                capacity: Int(count)
            ) { reboundPointer in
                host_statistics64(
                    mach_host_self(),
                    HOST_VM_INFO64,
                    reboundPointer,
                    &count
                )
            }
        }

        guard result == KERN_SUCCESS else {
            totalRAMGB = Double(totalBytes) / 1_073_741_824
            usedRAMGB = nil
            availableRAMGB = nil
            errorMessage = "Live RAM statistics are unavailable."
            return
        }

        let pageSize = UInt64(vm_kernel_page_size)

        let reclaimablePages =
            UInt64(statistics.free_count) +
            UInt64(statistics.inactive_count) +
            UInt64(statistics.speculative_count) +
            UInt64(statistics.purgeable_count)

        let availableBytes = min(
            totalBytes,
            reclaimablePages * pageSize
        )

        let usedBytes = totalBytes - availableBytes

        totalRAMGB = Double(totalBytes) / 1_073_741_824
        availableRAMGB = Double(availableBytes) / 1_073_741_824
        usedRAMGB = Double(usedBytes) / 1_073_741_824
    }

    private func refreshStorage() {
        do {
            let url = URL(fileURLWithPath: NSHomeDirectory())

            let values = try url.resourceValues(forKeys: [
                .volumeTotalCapacityKey,
                .volumeAvailableCapacityForImportantUsageKey,
                .volumeAvailableCapacityKey
            ])

            guard let totalBytes = values.volumeTotalCapacity,
                  totalBytes > 0 else {
                throw StorageError.unavailable
            }

            let availableBytes =
                values.volumeAvailableCapacityForImportantUsage ??
                values.volumeAvailableCapacity

            guard let availableBytes, availableBytes >= 0 else {
                throw StorageError.unavailable
            }

            let safeAvailable = min(
                Int64(totalBytes),
                Int64(availableBytes)
            )

            let usedBytes = Int64(totalBytes) - safeAvailable

            totalStorageGB = Double(totalBytes) / 1_073_741_824
            availableStorageGB =
                Double(safeAvailable) / 1_073_741_824
            usedStorageGB = Double(usedBytes) / 1_073_741_824

        } catch {
            totalStorageGB = nil
            usedStorageGB = nil
            availableStorageGB = nil
            errorMessage = "Storage information is unavailable."
        }
    }

    private enum StorageError: Error {
        case unavailable
    }
}
