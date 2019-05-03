
import UIKit
import Photos
import CoreData

class UserInfoViewControllerxxyyz: UIViewController {

    @IBOutlet weak var userInfoTV: UserInfoTableViewxxyyz!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "个人"
        
        userInfoTV.dataSource = userInfoTV.self
        userInfoTV.delegate = userInfoTV.self
        userInfoTV.xyyxvcInstance = self
        
        userInfoTV.xyyxuserInfo = xyyxgetSendBirdUserInfo(abbx: nil, abby: nil)
        
        self.userInfoTV.reloadData()
        
        var xyyxtoolItems = [UIBarButtonItem]()
        xyyxtoolItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        
        let xyyxcancelBtn = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 80, height: 80))
        xyyxcancelBtn.setTitle("关闭", for: UIControl.State.normal)
        xyyxcancelBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        xyyxcancelBtn.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)
        xyyxcancelBtn.addTargetClosure { (sender) in
            self.navigationController?.popViewController(animated: true)
        }
        xyyxtoolItems.append(UIBarButtonItem(customView: xyyxcancelBtn))
        
        self.toolbarItems = xyyxtoolItems
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        xyyxrequestPhotoAuth(abbx: nil, abby: nil)
    }

    func xyyxrequestPhotoAuth(abbx: String?, abby: String?) {
        let xyyxphotoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        if (xyyxphotoAuthorizationStatus == .notDetermined) {
            PHPhotoLibrary.requestAuthorization { (authorizationStatus) in
                self.xyyxrequestPhotoAuth(abbx: nil, abby: nil)
            }
        } else {
            if (xyyxphotoAuthorizationStatus != .authorized) {
                
                let xyyxalertController = UIAlertController(title: "同意使用相簿",
                                                        message: "您必须同意App存取相簿才能上传个人照片，照片将于您发布文章或留言时使用", preferredStyle: .alert)
                let xyyxokAction = UIAlertAction(title: "关闭", style: .default, handler: {
                    action in
                    self.navigationController?.popViewController(animated: true)
                })
                xyyxalertController.addAction(xyyxokAction)
                self.present(xyyxalertController, animated: true, completion: nil)
                
            }
        }
    }
}
