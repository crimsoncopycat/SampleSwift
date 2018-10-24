

import UIKit
//MARK: - UIAlertController
extension UIAlertController {
    class func tryToReloadAlert(message: String,reloadHandler: ((UIAlertAction) -> Void)?) -> UIAlertController{
        let alert = UIAlertController(title: "Error:", message: message, preferredStyle: .alert)
        let tryAgainAction = UIAlertAction(title: "Try again", style: .default, handler: reloadHandler)
        let suppressMessageAction = UIAlertAction(title: "Supress", style: .default, handler: nil)
        alert.addAction(tryAgainAction)
        alert.addAction(suppressMessageAction)
        return alert
    }
    
    class func alert(title: String? = nil, error: Swift.Error, handler: ((UIAlertAction?) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title ?? "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: handler))
        return alert
    }
    
    class func alertOnErrorWithMessage(_ message: String, handler: ((UIAlertAction?) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message:message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:handler))
        return alert
    }
    
    class func alert(message: String, handler: ((UIAlertAction?) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: "Message", message:message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:handler))
        return alert
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

protocol NetworkPerformerController {
    func showErrorAlert(with message: String, loaderContainer: UIView)
}

extension NetworkPerformerController where Self: UIViewController {
    func showErrorAlert(with message: String, loaderContainer: UIView) {
        let alert = UIAlertController.alert(message: message)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
