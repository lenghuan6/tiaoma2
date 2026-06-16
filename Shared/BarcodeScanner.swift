import AVFoundation
import Vision
import UIKit

final class BarcodeScanner: NSObject {
    var onResult: ((String) -> Void)?
    private let session = AVCaptureSession()
    private var isScanning = false
    
    override init() {
        super.init()
        setupSession()
    }
    
    private func setupSession() {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: device) else { return }
        
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "scan.queue"))
        output.alwaysDiscardsLateVideoFrames = true
        
        session.sessionPreset = .medium
        if session.canAddInput(input) { session.addInput(input) }
        if session.canAddOutput(output) { session.addOutput(output) }
    }
    
    func start() {
        guard !isScanning else { return }
        isScanning = true
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
        }
    }
    
    func stop() {
        guard isScanning else { return }
        isScanning = false
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.stopRunning()
        }
    }
}

extension BarcodeScanner: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let buffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let request = VNDetectBarcodesRequest { [weak self] req, _ in
            guard let results = req.results as? [VNBarcodeObservation],
                  let code = results.first?.payloadStringValue,
                  !code.isEmpty else { return }
            
            DispatchQueue.main.async {
                self?.stop()
                self?.onResult?(code)
            }
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: buffer, options: [:]).perform([request])
    }
}