import UIKit
import Photos

class RegisterViewControllerxxyyz: KeyboardViewControllerxxyyz, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var topBarTitleLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userImageBtn: UIButton!
    @IBOutlet weak var nicknameTitleLabel: UILabel!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var passwordTitleLabel: UILabel!
    @IBOutlet weak var confirmTitleLabel: UILabel!
    @IBOutlet weak var nicknameStrokeView: UIView!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailStrokeView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordStrokeView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmStrokeView: UIView!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    
    var xyyxsubmitClickCallback:((_ userInfo: UserInfoObjectxxyyz) -> Void)?
    var xyyxcancelClickCallback:(() -> Void)?
    
    let xyyximagePicker = UIImagePickerController()
    var xyyxsendBirdLoginChannelUrl:String = ""
    var xyyxuserImageUrl:String = ""
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        xyyximagePicker.delegate = self
        nicknameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
        
        backgroundImageView.contentMode = UIView.ContentMode.scaleAspectFill
        registerView.layer.cornerRadius = 5
        registerView.clipsToBounds = true
        userImageView.contentMode = UIView.ContentMode.scaleAspectFill
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        userImageView.clipsToBounds = true
        nicknameStrokeView.layer.cornerRadius = 3
        nicknameStrokeView.clipsToBounds = true
        nicknameTextField.layer.cornerRadius = 3
        nicknameTextField.clipsToBounds = true
        emailStrokeView.layer.cornerRadius = 3
        emailStrokeView.clipsToBounds = true
        emailTextField.layer.cornerRadius = 3
        emailTextField.clipsToBounds = true
        passwordStrokeView.layer.cornerRadius = 3
        passwordStrokeView.clipsToBounds = true
        passwordTextField.layer.cornerRadius = 3
        passwordTextField.clipsToBounds = true
        confirmStrokeView.layer.cornerRadius = 3
        confirmStrokeView.clipsToBounds = true
        confirmTextField.layer.cornerRadius = 3
        confirmTextField.clipsToBounds = true
        cancelBtn.layer.cornerRadius = 3
        cancelBtn.clipsToBounds = true
        submitBtn.layer.cornerRadius = 3
        submitBtn.clipsToBounds = true
        
        topBarView.backgroundColor = xyyxappMainColor
        topBarTitleLabel.textColor = xyyxappLightColor
        topBarTitleLabel.text = "注册"
        
        nicknameStrokeView.backgroundColor = xyyxappMainColor
        nicknameTitleLabel.textColor = xyyxappSubColor
        nicknameTitleLabel.text = "昵称"
        nicknameTextField.placeholder = "请输入昵称..."
        
        emailStrokeView.backgroundColor = xyyxappMainColor
        emailTitleLabel.textColor = xyyxappSubColor
        emailTitleLabel.text = "信箱"
        emailTextField.placeholder = "请输入电子邮件信箱..."
        
        passwordStrokeView.backgroundColor = xyyxappMainColor
        passwordTitleLabel.textColor = xyyxappSubColor
        passwordTitleLabel.text = "密码"
        passwordTextField.placeholder = "請輸入密碼..."
        
        confirmStrokeView.backgroundColor = xyyxappMainColor
        confirmTitleLabel.textColor = xyyxappSubColor
        confirmTitleLabel.text = "确认"
        confirmTextField.placeholder = "请再输入一次密码..."
        
        cancelBtn.layer.backgroundColor = xyyxappMainColor.cgColor
        cancelBtn.setTitleColor(xyyxappLightColor, for: UIControl.State.normal)
        cancelBtn.setTitle("取消", for: UIControl.State.normal)
        submitBtn.layer.backgroundColor = xyyxappMainColor.cgColor
        submitBtn.setTitleColor(xyyxappLightColor, for: UIControl.State.normal)
        submitBtn.setTitle("注册", for: UIControl.State.normal)
        
        userImageBtn.addTarget(self, action: #selector(xyyxuserImageBtnClick), for: UIControl.Event.touchUpInside)
        
        submitBtn.addTarget(self, action: #selector(xyyxsubmitBtnClick), for: UIControl.Event.touchUpInside)
        
        cancelBtn.addTarget(self, action: #selector(xyyxcancelBtnClick), for: UIControl.Event.touchUpInside)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        xyyxrequestPhotoAuth(abbx: nil, abby: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let xyyxpickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            dismiss(animated: true) {
                
                xyyxstartIndicator(abbx: nil, abby: nil, currentVC: self, callback: { (indicatorView01) in
                    xyyxuploadImageGetLink(abbx: nil, abby: nil, image: xyyxpickedImage) { (imageLink) in
                        self.xyyxuserImageUrl = imageLink
                        xyyxstopIndicator(abbx: nil, abby: nil, indicatorView: indicatorView01, callback: {
                            if (self.xyyxuserImageUrl.count > 0) {
                                xyyxstartIndicator(abbx: nil, abby: nil, currentVC: self, callback: { (indicatorView02) in
                                    xyyxdownloadImage(abbx: nil, abby: nil, url: self.xyyxuserImageUrl) { (image) in
                                        xyyxstopIndicator(abbx: nil, abby: nil, indicatorView: indicatorView02, callback: {
                                            self.userImageView.image = image
                                        })
                                    }
                                })
                            }
                        })
                    }
                })
                
            }
            
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func xyyxuserImageBtnClick() {
        self.xyyximagePicker.allowsEditing = false
        self.xyyximagePicker.sourceType = .photoLibrary
        self.present(self.xyyximagePicker, animated: true, completion: nil)
    }
    
    @objc func xyyxsubmitBtnClick() {
        if (self.nicknameTextField.text!.count > 0) {
            if (self.emailTextField.text!.count > 0) {
                if (self.passwordTextField.text!.count > 0) {
                    if (self.passwordTextField.text! == self.confirmTextField.text!) {
                        if (self.xyyxuserImageUrl.count > 0) {
                            xyyxstartIndicator(abbx: nil, abby: nil, currentVC: self) { (indicatorView) in
                                let xyyxuserInfoObj = UserInfoObjectxxyyz()
                                xyyxuserInfoObj.xyyxuserNickname = self.nicknameTextField.text!
                                xyyxuserInfoObj.xyyxuserEmail = self.emailTextField.text!
                                xyyxuserInfoObj.xyyxuserPassword = self.passwordTextField.text!
                                xyyxuserInfoObj.xyyxuserImageUrl = self.xyyxuserImageUrl
                                
                                xyyxsendAccountTo(abbx: nil, abby: nil, sendBirdAccountChannelUrl: self.xyyxsendBirdLoginChannelUrl, userInfo: xyyxuserInfoObj, didSendCallback: {
                                    
                                    xyyxstopIndicator(abbx: nil, abby: nil, indicatorView: indicatorView, callback: {
                                        
                                        if (self.xyyxsubmitClickCallback != nil) {
                                            self.xyyxsubmitClickCallback!(xyyxuserInfoObj)
                                        }
                                        
                                    })
                                    
                                })
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func xyyxcancelBtnClick() {
        if (xyyxcancelClickCallback != nil) {
            self.xyyxcancelClickCallback!()
        }
    }
    
    func xyyxsetParameter(abbx: String?, abby: String?, sendBirdLoginChannelUrl: String, didRegistedCallback: ((_ userInfo: UserInfoObjectxxyyz) -> Void)?, cancelCallback: (() -> Void)?) {
        self.xyyxsendBirdLoginChannelUrl = sendBirdLoginChannelUrl
        self.xyyxsubmitClickCallback = didRegistedCallback
        self.xyyxcancelClickCallback = cancelCallback
    }
    
    func xyyxrequestPhotoAuth(abbx: String?, abby: String?) {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        if (photoAuthorizationStatus == .notDetermined) {
            PHPhotoLibrary.requestAuthorization { (authorizationStatus) in
                self.xyyxrequestPhotoAuth(abbx: nil, abby: nil)
            }
        } else {
            if (photoAuthorizationStatus != .authorized) {
                
                let alertController = UIAlertController(title: "同意App使用相簿",
                                                        message: "您必须同意App存取相簿才能上传个人照片，照片将于您发布文章或留言时使用", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "关闭", style: .default, handler: {
                    action in
                    self.navigationController?.popViewController(animated: true)
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
    }

}
