import UIKit

class LoginViewControllerxxyyz: KeyboardViewControllerxxyyz {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var topBarTitleLabel: UILabel!
    @IBOutlet weak var accountTitleLabel: UILabel!
    @IBOutlet weak var passwordTitleLabel: UILabel!
    @IBOutlet weak var accountStrokeView: UIView!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordStrokeView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var xyyxsendBirdAccountChannelUrl:String = ""
    var xyyxconfirmClickCallback:((_ userInfo: UserInfoObjectxxyyz) -> Void)?
    var xyyxcancelClickCallback:(() -> Void)?
    
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
        
        accountTextField.delegate = self
        passwordTextField.delegate = self
        
        backgroundImageView.contentMode = UIView.ContentMode.scaleAspectFill
        loginView.layer.cornerRadius = 5
        loginView.clipsToBounds = true
        accountStrokeView.layer.cornerRadius = 3
        accountStrokeView.clipsToBounds = true
        accountTextField.layer.cornerRadius = 3
        accountTextField.clipsToBounds = true
        passwordStrokeView.layer.cornerRadius = 3
        passwordStrokeView.clipsToBounds = true
        passwordTextField.layer.cornerRadius = 3
        passwordTextField.clipsToBounds = true
        cancelBtn.layer.cornerRadius = 3
        cancelBtn.clipsToBounds = true
        confirmBtn.layer.cornerRadius = 3
        confirmBtn.clipsToBounds = true
        
        topBarView.backgroundColor = xyyxappMainColor
        topBarTitleLabel.textColor = xyyxappLightColor
        topBarTitleLabel.text = "登入"
        accountStrokeView.backgroundColor = xyyxappMainColor
        accountTitleLabel.textColor = xyyxappSubColor
        accountTitleLabel.text = "信箱"
        accountTextField.placeholder = "请输入电子邮件信箱..."
        passwordStrokeView.backgroundColor = xyyxappMainColor
        passwordTitleLabel.textColor = xyyxappSubColor
        passwordTitleLabel.text = "密码"
        passwordTextField.placeholder = "请输入密码..."
        cancelBtn.layer.backgroundColor = xyyxappMainColor.cgColor
        cancelBtn.setTitleColor(xyyxappLightColor, for: UIControl.State.normal)
        cancelBtn.setTitle("注册", for: UIControl.State.normal)
        confirmBtn.layer.backgroundColor = xyyxappMainColor.cgColor
        confirmBtn.setTitleColor(xyyxappLightColor, for: UIControl.State.normal)
        confirmBtn.setTitle("登入", for: UIControl.State.normal)
        
        confirmBtn.addTarget(self, action: #selector(xyyxconfirmBtnClick), for: UIControl.Event.touchUpInside)
        
        cancelBtn.addTarget(self, action: #selector(xyyxcancelBtnClick), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func xyyxconfirmBtnClick() {
        
        xyyxstartIndicator(abbx: nil, abby: nil, currentVC: self, callback: { (indicatorView) in
            xyyxgetAccountsFrom(abbx: nil, abby: nil, sendBirdAccountChannelUrl: self.xyyxsendBirdAccountChannelUrl) { (userInfoArray) in
                var index = -1
                for i in 0..<userInfoArray.count {
                    if (userInfoArray[i].xyyxuserEmail == self.accountTextField.text!) {
                        if (userInfoArray[i].xyyxuserPassword == self.passwordTextField.text!) {
                            index = i
                            break
                        }
                    }
                }
                xyyxstopIndicator(abbx: nil, abby: nil, indicatorView: indicatorView, callback: {
                    
                    if (index >= 0) {
                        xyyxsetSendBirdUserInfo(abbx: nil, abby: nil, userNickname: userInfoArray[index].xyyxuserNickname, userEmail: userInfoArray[index].xyyxuserEmail, userImageUrl: userInfoArray[index].xyyxuserImageUrl, userPassword: userInfoArray[index].xyyxuserPassword)
                        if (self.xyyxconfirmClickCallback != nil) {
                            self.xyyxconfirmClickCallback!(userInfoArray[index])
                        }
                    }
                    
                })
                
            }
        })
        
    }
    
    @objc func xyyxcancelBtnClick() {
        if (xyyxcancelClickCallback != nil) {
            self.xyyxcancelClickCallback!()
        }
    }
    
    func xyyxsetParameter(abbx: String?, abby: String?, sendBirdAccountChannelUrl: String, didLoginCallback: ((_ userInfo:UserInfoObjectxxyyz) -> Void)?, cancelCallback: (() -> Void)?) {
        self.xyyxsendBirdAccountChannelUrl = sendBirdAccountChannelUrl
        self.xyyxconfirmClickCallback = didLoginCallback
        self.xyyxcancelClickCallback = cancelCallback
    }

}
