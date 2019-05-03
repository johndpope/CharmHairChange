import UIKit

class SendBirdNavigationControllerxxyyz: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barTintColor = xyyxappMainColor
        self.navigationBar.tintColor = xyyxappLightColor
        
        var xyyxmTitleAttributes = [NSAttributedString.Key:Any]()
        xyyxmTitleAttributes[NSAttributedString.Key.font] = xyyxmTitleFont
        xyyxmTitleAttributes[NSAttributedString.Key.foregroundColor] = xyyxappLightColor
        self.navigationBar.titleTextAttributes = xyyxmTitleAttributes
        
        self.interactivePopGestureRecognizer?.delegate = self
        
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

}
