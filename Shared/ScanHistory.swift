import Foundation

final class ScanHistory {
    static let shared = ScanHistory()
    private let key = "BarcodeScanHistory"
    private let maxCount = 50
    
    var list: [String] {
        get {
            UserDefaults.standard.stringArray(forKey: key) ?? []
        }
        set {
            var arr = newValue
            if arr.count > maxCount {
                arr = Array(arr.prefix(maxCount))
            }
            UserDefaults.standard.set(arr, forKey: key)
        }
    }
    
    func add(_ text: String) {
        guard !text.isEmpty else { return }
        var arr = list
        arr.removeAll { $0 == text }
        arr.insert(text, at: 0)
        list = arr
    }
}