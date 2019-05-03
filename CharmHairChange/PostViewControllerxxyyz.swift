import UIKit
import Photos
import CoreData

class PostViewControllerxxyyz: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cateArrowImage: UIImageView!
    @IBOutlet weak var cateView: UIView!
    @IBOutlet weak var cateLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var tagTitleLabel: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    
    
    var spinner:SimpleSpinnerxxyyz?
    @IBOutlet weak var mainTextField: UITextField!
    @IBOutlet weak var subTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tagAddBtn: UIButton!
    @IBOutlet weak var postImageIndicator: UIActivityIndicatorView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var postImageBtn: UIButton!
    
    @IBOutlet weak var sendIndicatorView: UIView!
    @IBOutlet weak var sendIndicator: UIActivityIndicatorView!
    
    var xyyxnextMenuId = 0
    let xyyximagePicker = UIImagePickerController()
    var xyyximageLink:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "发布文章"
        
        cateLabel.text = "文章类别："
        mainLabel.text = "主要标题："
        subLabel.text = "副要标题："
        urlLabel.text = "网址连结："
        tagTitleLabel.text = "附加标签："
        imageLabel.text = "上传图片："
        
        cateLabel.textColor = xyyxappSubColor
        mainLabel.textColor = xyyxappSubColor
        subLabel.textColor = xyyxappSubColor
        urlLabel.textColor = xyyxappSubColor
        tagTitleLabel.textColor = xyyxappSubColor
        imageLabel.textColor = xyyxappSubColor
        tagAddBtn.backgroundColor = xyyxappSubColor
        cateArrowImage.image = xyyxgetDownArrow(abbx: nil, abby: nil, imageSize: 50.0, color: xyyxappSubColor)
        if let xyyxspVC = self.splitViewController as? SplitViewControllerxxyyz {
            if let xyyxrootVC = xyyxspVC.xyyxrootVC {
                spinner = SimpleSpinnerxxyyz()
                spinner!.xyyxcreateSpinner(abbx: nil, abby: nil, insideOfView: self.cateView, titleArray: xyyxrootVC.rootTV.xyyxrootViewDataArray, textAlignment: NSTextAlignment.left, dropTextAlignment: UIControl.ContentHorizontalAlignment.left, callback: { (position) in
                    
                })
            }
        }
        mainTextField.text = ""
        subTextField.text = ""
        urlTextField.text = ""
        tagLabel.text = ""
        tagAddBtn.addTargetClosure { (sender) in
            
            let xyyxcontroller = UIAlertController(title: "标签", message: "标签之间请用 ',' 逗号隔开", preferredStyle: .alert)
            xyyxcontroller.addTextField { (textField) in
                textField.placeholder = "请输入 标签1,标签2,标签3 ..."
                if (self.tagLabel.text!.count > 0) {
                    textField.text = self.tagLabel.text
                } else {
                    textField.text = ""
                }
            }
            let xyyxokAction = UIAlertAction(title: "确定", style: .default) { (_) in
                self.tagLabel.text = xyyxcontroller.textFields?[0].text
            }
            xyyxcontroller.addAction(xyyxokAction)
            let xyyxcancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            xyyxcontroller.addAction(xyyxcancelAction)
            self.present(xyyxcontroller, animated: true, completion: nil)
            
        }
        postImageView.image = nil
        postImageIndicator.isHidden = true
        postImageIndicator.stopAnimating()
        postImageBtn.addTargetClosure { (sender) in
            self.xyyximagePicker.allowsEditing = false
            self.xyyximagePicker.sourceType = .photoLibrary
            self.present(self.xyyximagePicker, animated: true, completion: nil)
        }
        xyyximagePicker.delegate = self
        
        
        var xyyxtoolItems = [UIBarButtonItem]()
        xyyxtoolItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        
        let xyyxcancelBtn = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 80, height: 80))
        xyyxcancelBtn.setTitle("取消", for: UIControl.State.normal)
        xyyxcancelBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        xyyxcancelBtn.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)
        xyyxcancelBtn.addTargetClosure { (sender) in
            self.navigationController?.popViewController(animated: true)
        }
        xyyxtoolItems.append(UIBarButtonItem(customView: xyyxcancelBtn))
        
        let xyyxsendBtn = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 80 , height: 80))
        xyyxsendBtn.setTitle("发布", for: UIControl.State.normal)
        xyyxsendBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        xyyxsendBtn.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)
        xyyxsendBtn.addTargetClosure { (sender) in
            self.xyyxsendBtnClick()
        }
        xyyxtoolItems.append(UIBarButtonItem(customView: xyyxsendBtn))
        
        self.toolbarItems = xyyxtoolItems
        
        sendIndicatorView.backgroundColor = xyyxappMaskColor
        sendIndicatorView.isHidden = true
        sendIndicator.stopAnimating()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let xyyxspVC = self.splitViewController as? SplitViewControllerxxyyz {
            self.xyyxnextMenuId = 0
            for i in 0..<xyyxspVC.xyyxtotalPageArray.count {
                if (xyyxspVC.xyyxtotalPageArray[i].xyyxmenuId > self.xyyxnextMenuId) {
                    self.xyyxnextMenuId = xyyxspVC.xyyxtotalPageArray[i].xyyxmenuId
                }
            }
            self.xyyxnextMenuId = self.xyyxnextMenuId + 1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        xyyxrequestPhotoAuth(abbx: nil, abby: nil)
        
    }
    
    func xyyxsendBtnClick() {
        if (self.xyyximageLink.count > 0) {
            if (URL(string: self.xyyximageLink) != nil) {
                if (self.urlTextField.text!.count > 0) {
                    if (URL(string: self.urlTextField.text!) != nil) {
                        if (self.spinner!.spinnerDefaultItemPosition >= 0) {
                            if (mainTextField.text!.count > 0) {
                                if (subTextField.text!.count > 0) {
                                    
                                    if let xyyxspVC = self.splitViewController as? SplitViewControllerxxyyz {
                                        if let xyyxrootVC = xyyxspVC.xyyxrootVC {
                                            
                                            let xyyxnewPageObj = NewPageObjectxxyyz()
                                            xyyxnewPageObj.xyyxuserNickname = xyyxgetSendBirdUserInfo(abbx: nil, abby: nil).xyyxuserNickname
                                            xyyxnewPageObj.xyyxuserEmail = xyyxgetSendBirdUserInfo(abbx: nil, abby: nil).xyyxuserEmail
                                            xyyxnewPageObj.xyyxuserImageUrl = xyyxgetSendBirdUserInfo(abbx: nil, abby: nil).xyyxuserImageUrl
                                            xyyxnewPageObj.xyyxcateName = xyyxrootVC.rootTV.xyyxrootViewDataArray[self.spinner!.spinnerDefaultItemPosition]
                                            xyyxnewPageObj.xyyxtitleName = self.mainTextField.text!
                                            xyyxnewPageObj.xyyxsubTitleName = self.subTextField.text!
                                            xyyxnewPageObj.xyyximageUrl = self.xyyximageLink
                                            let xyyxdf = DateFormatter()
                                            xyyxdf.dateFormat = "yyyy-MM-dd"
                                            xyyxdf.string(from: Date())
                                            xyyxnewPageObj.xyyxeditTime = xyyxdf.string(from: Date())
                                            xyyxnewPageObj.xyyxmenuId = self.xyyxnextMenuId
                                            xyyxnewPageObj.xyyxpageUrl = self.urlTextField.text!
                                            let xyyxtagArray = self.tagLabel.text!.components(separatedBy: ",")
                                            xyyxnewPageObj.xyyxtagName = xyyxtagArray
                                            xyyxsendNewPageTo(abbx: nil, abby: nil, sendBirdNewPageChannelUrl: xyyxappSendBirdNewPageChannelUrl, newPageObject: xyyxnewPageObj) {
                                                
                                                xyyxspVC.xyyxresetData(abbx: nil, abby: nil) {
                                                    self.navigationController?.popViewController(animated: true)
                                                }
                                                
                                            }
                                            
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let xyyxpickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.postImageIndicator.startAnimating()
            self.postImageIndicator.isHidden = false
            xyyxuploadImageGetLink(abbx: nil, abby: nil, image: xyyxpickedImage) { (imageLink) in
                self.postImageIndicator.isHidden = true
                self.postImageIndicator.stopAnimating()
                self.xyyximageLink = imageLink
                if (self.xyyximageLink.count > 0) {
                    self.postImageIndicator.startAnimating()
                    self.postImageIndicator.isHidden = false
                    xyyxdownloadImage(abbx: nil, abby: nil, url: self.xyyximageLink) { (image) in
                        self.postImageIndicator.isHidden = true
                        self.postImageIndicator.stopAnimating()
                        self.postImageViewHeight.constant = self.postImageView.frame.width * image!.size.height / image!.size.width
                        self.postImageView.image = image
                    }
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
    }

}
