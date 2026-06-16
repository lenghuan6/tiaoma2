import UIKit
import SwiftUI

class KeyboardViewController: UIInputViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardUI()
    }
    
    private func setupKeyboardUI() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stack.topAnchor.constraint(equalTo: view.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let scanBtn = UIButton(type: .system)
        scanBtn.setTitle("📷 扫描条码", for: .normal)
        scanBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        scanBtn.addTarget(self, action: #selector(openScan), for: .touchUpInside)
        scanBtn.backgroundColor = .systemBlue
        scanBtn.setTitleColor(.white, for: .normal)
        scanBtn.layer.cornerRadius = 8
        stack.addArrangedSubview(scanBtn)
        
        let doneBtn = UIButton(type: .system)
        doneBtn.setTitle("完成", for: .normal)
        doneBtn.addTarget(self, action: #selector(dismissKb), for: .touchUpInside)
        doneBtn.backgroundColor = .systemGray3
        doneBtn.layer.cornerRadius = 8
        stack.addArrangedSubview(doneBtn)
    }
    
    @objc private func openScan() {
        let scanView = ScanCameraView { [weak self] code in
            self?.textDocumentProxy.insertText(code)
        }
        let host = UIHostingController(rootView: scanView)
        host.modalPresentationStyle = .fullScreen
        present(host, animated: true)
    }
    
    @objc private func dismissKb() {
        dismissKeyboard()
    }
}