import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("条码输入法")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("适配 iOS 16.6 | 配合 TrollStore 使用")
                .foregroundColor(.gray)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("使用说明：")
                    .font(.headline)
                Text("1. 前往 设置 > 通用 > 键盘 > 添加新键盘")
                Text("2. 选择「条码输入法」，并开启【允许完全访问】")
                Text("3. 切换键盘后，点击扫描按钮即可识别一/二维码")
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}