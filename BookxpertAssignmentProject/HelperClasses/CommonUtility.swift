import Foundation
import UIKit
import SVProgressHUD

class CommonUtils {
    /// Show Progress Hud
    /// - Parameter show: Boolean value to show/Hide
    static func showHud(show: Bool) {
        if show == true {
            SVProgressHUD.setDefaultMaskType(.none)
            SVProgressHUD.setDefaultStyle(.custom)
            SVProgressHUD.setForegroundColor(.blue)     // .themeBlue
            SVProgressHUD.setBackgroundColor(.white)
            SVProgressHUD.show()
        } else {
            SVProgressHUD.dismiss()
        }
    }
}
