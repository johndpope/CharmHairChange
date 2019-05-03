import UIKit

class SendDiscussViewControllerxxyyz: KeyboardViewControllerxxyyz {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var sendDiscussView: UIView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var topBarTitleLabel: UILabel!
    @IBOutlet weak var subjectTitleLabel: UILabel!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var subjectStrokeView: UIView!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var contentStrokeView: UIView!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var sendBtn: UIButton!
    
    var xyyxsendBirdDiscussChannelUrl:String = ""
    var xyyxaccordingObject:DiscussAccordingObjectxxyyz = DiscussAccordingObjectxxyyz()
    var xyyxsendClickCallback:((_ discussObj: DiscussObjectxxyyz) -> Void)?
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
        
        subjectTextField.delegate = self
        contentTextField.delegate = self
        
        backgroundImageView.contentMode = UIView.ContentMode.scaleAspectFill
        sendDiscussView.layer.cornerRadius = 5
        sendDiscussView.clipsToBounds = true
        subjectStrokeView.layer.cornerRadius = 3
        subjectStrokeView.clipsToBounds = true
        subjectTextField.layer.cornerRadius = 3
        subjectTextField.clipsToBounds = true
        contentStrokeView.layer.cornerRadius = 3
        contentStrokeView.clipsToBounds = true
        contentTextField.layer.cornerRadius = 3
        contentTextField.clipsToBounds = true
        cancelBtn.layer.cornerRadius = 3
        cancelBtn.clipsToBounds = true
        sendBtn.layer.cornerRadius = 3
        sendBtn.clipsToBounds = true
        
        topBarView.backgroundColor = xyyxappMainColor
        topBarTitleLabel.textColor = xyyxappLightColor
        topBarTitleLabel.text = "评论"
        
        subjectStrokeView.backgroundColor = xyyxappMainColor
        subjectTitleLabel.textColor = xyyxappSubColor
        subjectTitleLabel.text = "主题"
        
        contentStrokeView.backgroundColor = xyyxappMainColor
        contentTitleLabel.textColor = xyyxappSubColor
        contentTitleLabel.text = "内容"
        
        cancelBtn.layer.backgroundColor = xyyxappMainColor.cgColor
        cancelBtn.setTitleColor(xyyxappLightColor, for: UIControl.State.normal)
        cancelBtn.setTitle("取消", for: UIControl.State.normal)
        sendBtn.layer.backgroundColor = xyyxappMainColor.cgColor
        sendBtn.setTitleColor(xyyxappLightColor, for: UIControl.State.normal)
        sendBtn.setTitle("发布", for: UIControl.State.normal)
        
        sendBtn.addTarget(self, action: #selector(xyyxsendBtnClick), for: UIControl.Event.touchUpInside)
        
        cancelBtn.addTarget(self, action: #selector(xyyxcancelBtnClick), for: UIControl.Event.touchUpInside)
        
        
    }
    
    @objc func xyyxsendBtnClick() {
        if (self.subjectTextField.text!.count > 0) {
            if (self.contentTextField.text!.count > 0) {
                
                xyyxstartIndicator(abbx: nil, abby: nil, currentVC: self) { (indicatorView) in
                    let xyyxdiscussObj = DiscussObjectxxyyz()
                    xyyxdiscussObj.xyyxdiscussId = Int(Date().timeIntervalSince1970)
                    xyyxdiscussObj.xyyxsubject = self.subjectTextField.text!
                    xyyxdiscussObj.xyyxcontent = self.contentTextField.text!
                    let df = DateFormatter()
                    df.dateFormat = "yyyy-MM-dd"
                    df.string(from: Date())
                    xyyxdiscussObj.xyyxdate = df.string(from: Date())
                    xyyxdiscussObj.xyyxaccording = self.xyyxaccordingObject
                    
                    xyyxsendDiscussTo(abbx: nil, abby: nil, sendBirdDiscussChannelUrl: self.xyyxsendBirdDiscussChannelUrl, discussObject: xyyxdiscussObj, didSendCallback: {
                        
                        xyyxstopIndicator(abbx: nil, abby: nil, indicatorView: indicatorView, callback: {
                            
                            if (self.xyyxsendClickCallback != nil) {
                                self.xyyxsendClickCallback!(xyyxdiscussObj)
                            }
                            
                        })
                        
                    })
                }
            }
        }
    }
    
    @objc func xyyxcancelBtnClick() {
        if (xyyxcancelClickCallback != nil) {
            xyyxcancelClickCallback!()
        }
    }
    
    func xyyxsetParameter(abbx: String?, abby: String?, sendBirdDiscussChannelUrl: String, accordingObj:DiscussAccordingObjectxxyyz, didSendCallback: ((_ discussObj: DiscussObjectxxyyz) -> Void)?, cancelCallback: (() -> Void)?) {
        self.xyyxsendBirdDiscussChannelUrl = sendBirdDiscussChannelUrl
        self.xyyxaccordingObject = accordingObj
        self.xyyxsendClickCallback = didSendCallback
        self.xyyxcancelClickCallback = cancelCallback
    }

}
