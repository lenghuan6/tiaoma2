import UIKit
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "1. 请前往 设置 -> 通用 -> 键盘\n2. 添加 'TiaomaKeyboard'\n3. 点击它并开启 '允许完全访问'\n\n(首次打开本App已自动请求相机权限)"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.frame = CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width - 40, height: 300)
        vc.view.addSubview(label)
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        // 提前请求相机权限，确保 Extension 能调用
        AVCaptureDevice.requestAccess(for: .video) { _ in }
        
        return true
    }
}
