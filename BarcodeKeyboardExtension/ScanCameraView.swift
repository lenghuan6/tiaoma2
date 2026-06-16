import SwiftUI
import AVFoundation

struct ScanCameraView: View {
    @State private let scanner = BarcodeScanner()
    let onFinish: (String) -> Void
    @Environment(\.dismiss) var dismiss
    
    init(onFinish: @escaping (String) -> Void) {
        self.onFinish = onFinish
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Text("正在扫描条码/二维码...")
                .foregroundColor(.white)
                .font(.title)
            
            VStack {
                Spacer()
                Button("取消") {
                    scanner.stop()
                    dismiss()
                }
                .padding(.bottom, 40)
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear {
            scanner.onResult = { code in
                ScanHistory.shared.add(code)
                onFinish(code)
                dismiss()
            }
            scanner.start()
        }
        .onDisappear {
            scanner.stop()
        }
    }
}