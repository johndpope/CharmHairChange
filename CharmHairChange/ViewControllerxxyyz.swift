import UIKit
import CoreData
import CoreImage
import Vision
import Photos

class ViewControllerxxyyz: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var featuresMainView: UIView!
    
    @IBOutlet weak var personalImageView: UIImageView!
    var pickedImage:UIImage!
    var hairImageOffsetArray:[HairImageOffsetObject] = [HairImageOffsetObject]()
    var faceBoxView:UIImageView?
    
    @IBOutlet weak var takePhotoBtn: UIButton!
    @IBOutlet weak var pickPhotoBtn: UIButton!
    @IBOutlet weak var changeHairBtn: UIButton!
    var currentHairIndex = 1
    
    @IBOutlet weak var viewControllerTV: ViewControllerTableViewxxyyz!
    
    @IBOutlet weak var noneLabel: UILabel!
    
    let xyyxhomeName = "首页"
    let xyyxattentionName = "关注"
    let xyyxpostName = "发文"
    let xyyxcommentName = "评论"
    let xyyxuserInfoName = "个人"
    let xyyxnoneAttentionName = "您没关注任何文章"
    
    var xyyxselectCateName = ""
    var xyyxtoolbarSelectIndex = 3
    var xyyxuserInfo = UserInfoObjectxxyyz()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initFeatures()
        
        self.title = xyyxfeaturesName
        
        viewControllerTV.contentInset = UIEdgeInsets(top: CGFloat(5), left: CGFloat(0), bottom: CGFloat(5), right: CGFloat(0))
        viewControllerTV.dataSource = viewControllerTV.self
        viewControllerTV.delegate = viewControllerTV.self
        viewControllerTV.vcInstance = self
        
        self.navigationController?.definesPresentationContext = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.toolbar.barTintColor = self.navigationController?.navigationBar.barTintColor
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        requestPhotoAuth(abbx: nil, abby: nil)
        
        if let xyyxtoolbarHeight = self.navigationController?.toolbar.frame.size.height {
            if let xyyxtoobarWidth = self.navigationController?.toolbar.frame.size.width {
                var xyyxtoolItems = [UIBarButtonItem]()
                
                xyyxtoolItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
                
                let xyyxhomeBtn = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: (xyyxtoobarWidth - 20) / 5, height: xyyxtoolbarHeight))
                xyyxhomeBtn.setTitle(xyyxhomeName, for: UIControl.State.normal)
                xyyxhomeBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
                xyyxhomeBtn.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)
                xyyxhomeBtn.addTargetClosure { (sender) in
                    self.xyyxshowFeatures(abbx: nil, abby: nil)
                }
                xyyxtoolItems.append(UIBarButtonItem(customView: xyyxhomeBtn))
                
                let xyyxattentionBtn = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: (xyyxtoobarWidth - 20) / 5, height: xyyxtoolbarHeight))
                xyyxattentionBtn.setTitle(xyyxattentionName, for: UIControl.State.normal)
                xyyxattentionBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
                xyyxattentionBtn.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)
                xyyxattentionBtn.addTargetClosure { (sender) in
                    self.xyyxshowAttention(abbx: nil, abby: nil)
                }
                xyyxtoolItems.append(UIBarButtonItem(customView: xyyxattentionBtn))
                
                let xyyxpostBtn = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: (xyyxtoobarWidth - 20) / 5, height: xyyxtoolbarHeight))
                xyyxpostBtn.setTitle(xyyxpostName, for: UIControl.State.normal)
                xyyxpostBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
                xyyxpostBtn.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)
                xyyxpostBtn.addTargetClosure { (sender) in
                    self.xyyxshowPost(abbx: nil, abby: nil)
                }
                xyyxtoolItems.append(UIBarButtonItem(customView: xyyxpostBtn))
                
                let xyyxcommentBtn = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: (xyyxtoobarWidth - 20) / 5, height: xyyxtoolbarHeight))
                xyyxcommentBtn.setTitle(xyyxcommentName, for: UIControl.State.normal)
                xyyxcommentBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
                xyyxcommentBtn.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)
                xyyxcommentBtn.addTargetClosure { (sender) in
                    self.xyyxshowComment(abbx: nil, abby: nil)
                }
                xyyxtoolItems.append(UIBarButtonItem(customView: xyyxcommentBtn))
                
                let xyyxuserInfoBtn = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: (xyyxtoobarWidth - 20) / 5, height: xyyxtoolbarHeight))
                xyyxuserInfoBtn.setTitle(xyyxuserInfoName, for: UIControl.State.normal)
                xyyxuserInfoBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
                xyyxuserInfoBtn.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)
                xyyxuserInfoBtn.addTargetClosure { (sender) in
                    self.xyyxshowUserInfo(abbx: nil, abby: nil)
                }
                xyyxtoolItems.append(UIBarButtonItem(customView: xyyxuserInfoBtn))
                
                xyyxtoolItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
                
                self.toolbarItems = xyyxtoolItems
            }
        }
        
        if (self.xyyxtoolbarSelectIndex == 1) {
            self.xyyxshowAttention(abbx: nil, abby: nil)
        } else if (self.xyyxtoolbarSelectIndex == 2) {
            self.xyyxupdateCateSelect(abbx: nil, abby: nil)
        } else if (self.xyyxtoolbarSelectIndex == 3) {
            self.xyyxshowFeatures(abbx: nil, abby: nil)
        }
        
    }
    
    func xyyxshowAttention(abbx: String?, abby: String?) {
        self.title = xyyxattentionName
        self.xyyxtoolbarSelectIndex = 1
        self.featuresMainView.isHidden = true
        self.viewControllerTV.isHidden = false
        self.noneLabel.isHidden = true
        
        self.viewControllerTV.cateDataList = [NewPageObjectxxyyz]()
        for i in 0..<self.viewControllerTV.allDataList.count {
            if (self.viewControllerTV.allDataList[i].xyyxisAttention) {
                self.viewControllerTV.cateDataList.append(self.viewControllerTV.allDataList[i])
            }
        }
        
        if (self.viewControllerTV.cateDataList.count > 0) {
            self.viewControllerTV.isHidden = false
            self.noneLabel.isHidden = true
        } else {
            self.noneLabel.text = xyyxnoneAttentionName
            self.viewControllerTV.isHidden = true
            self.noneLabel.isHidden = false
        }
        
        self.viewControllerTV.reloadData()
    }
    
    func xyyxshowPost(abbx: String?, abby: String?) {
        let xyyxstoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let xyyxnextVC = xyyxstoryBoard.instantiateViewController(withIdentifier: "postVC") as! PostViewControllerxxyyz
        self.navigationController?.pushViewController(xyyxnextVC, animated: true)
    }
    
    func xyyxshowComment(abbx: String?, abby: String?) {
        
        let xyyxdiscussVC = UIStoryboard(name: "Tools", bundle: nil).instantiateViewController(withIdentifier: "queryDiscussVC") as! QueryDiscussViewControllerxxyyz
        
        xyyxdiscussVC.xyyxsetParameter(abbx: nil, abby: nil, sendBirdDiscussChannelUrl: xyyxappSendBirdDiscussChannelUrl, sendBirdRepostChannelUrl: xyyxappSendBirdRepostChannelUrl, sendBirdLikeChannelUrl: xyyxappSendBirdLikeChannelUrl, userInfo: xyyxgetSendBirdUserInfo(abbx: nil, abby: nil), accordingCallback: { (discussObj) in
            // according
            
            var xyyxtitle = " "
            if (discussObj.xyyxaccording.xyyxaccordingTitle.count > 0) {
                xyyxtitle = discussObj.xyyxaccording.xyyxaccordingTitle
            }
            let xyyxoverWebVC = OverWebViewControllerxxyyz(abbx: nil, abby: nil, title: xyyxtitle)
            UIApplication.shared.keyWindow?.rootViewController?.present(xyyxoverWebVC, animated: true, completion: {
                
                xyyxoverWebVC.xyyxloadMultiUrl(abbx: nil, abby: nil, urls: [discussObj.xyyxaccording.xyyxaccordingUrl])
                
                
            })
            
        }) { (discussObj) in
            // repost
            let xyyxrepostVC = UIStoryboard(name: "Tools", bundle: nil).instantiateViewController(withIdentifier: "repostDiscussVC") as! RepostDiscussViewControllerxxyyz
            
            xyyxrepostVC.xyyxsetParameter(abbx: nil, abby: nil,sendBirdDiscussChannelUrl: xyyxappSendBirdDiscussChannelUrl, sendBirdRepostChannelUrl: xyyxappSendBirdRepostChannelUrl, discussId: discussObj.xyyxdiscussId, userInfo: xyyxgetSendBirdUserInfo(abbx: nil, abby: nil))
            
            xyyxdiscussVC.navigationController?.pushViewController(xyyxrepostVC, animated: true)
        }
        
        self.navigationController?.pushViewController(xyyxdiscussVC, animated: true)
        
    }
    
    func xyyxshowUserInfo(abbx: String?, abby: String?) {
        let xyyxstoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let xyyxnextVC = xyyxstoryBoard.instantiateViewController(withIdentifier: "userInfoVC") as! UserInfoViewControllerxxyyz
        self.navigationController?.pushViewController(xyyxnextVC, animated: true)
    }
    
    func xyyxupdateCateSelect(abbx: String?, abby: String?) {
        self.title = self.xyyxselectCateName
        self.xyyxtoolbarSelectIndex = 2
        if let xyyxspVC = self.navigationController?.splitViewController as? SplitViewControllerxxyyz {
            if let xyyxrootVC = xyyxspVC.xyyxrootVC {
                if (xyyxrootVC.rootTV.xyyxrootViewDataArray.count > 0) {
                    self.featuresMainView.isHidden = true
                    self.viewControllerTV.isHidden = false
                    self.viewControllerTV.cateDataList = [NewPageObjectxxyyz]()
                    for i in 0..<self.viewControllerTV.allDataList.count {
                        if (self.viewControllerTV.allDataList[i].xyyxcateName == self.xyyxselectCateName) {
                            self.viewControllerTV.cateDataList.append(self.viewControllerTV.allDataList[i])
                        }
                    }
                    self.viewControllerTV.reloadData()
                } else {
                    self.featuresMainView.isHidden = true
                    self.viewControllerTV.isHidden = false
                    self.viewControllerTV.cateDataList = [NewPageObjectxxyyz]()
                    for i in 0..<self.viewControllerTV.allDataList.count {
                        if (self.viewControllerTV.allDataList[i].xyyxcateName == self.xyyxselectCateName) {
                            self.viewControllerTV.cateDataList.append(self.viewControllerTV.allDataList[i])
                        }
                    }
                    self.viewControllerTV.reloadData()
                }
            } else {
                self.featuresMainView.isHidden = true
                self.viewControllerTV.isHidden = false
                self.viewControllerTV.cateDataList = [NewPageObjectxxyyz]()
                for i in 0..<self.viewControllerTV.allDataList.count {
                    if (self.viewControllerTV.allDataList[i].xyyxcateName == self.xyyxselectCateName) {
                        self.viewControllerTV.cateDataList.append(self.viewControllerTV.allDataList[i])
                    }
                }
                self.viewControllerTV.reloadData()
            }
        } else {
            self.featuresMainView.isHidden = true
            self.viewControllerTV.isHidden = false
            self.viewControllerTV.cateDataList = [NewPageObjectxxyyz]()
            for i in 0..<self.viewControllerTV.allDataList.count {
                if (self.viewControllerTV.allDataList[i].xyyxcateName == self.xyyxselectCateName) {
                    self.viewControllerTV.cateDataList.append(self.viewControllerTV.allDataList[i])
                }
            }
            self.viewControllerTV.reloadData()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    // 以下为扩充功能
    
    func xyyxshowFeatures(abbx: String?, abby: String?) {
        self.title = xyyxfeaturesName
        self.xyyxtoolbarSelectIndex = 3
        self.viewControllerTV.isHidden = true
        self.noneLabel.isHidden = true
        self.featuresMainView.isHidden = false
        
    }
    
    func initFeatures() {
        
        hairImageOffsetArray = [HairImageOffsetObject]()
        let hair01 = HairImageOffsetObject()
        hair01.imageName = "hair_01.png"
        hair01.topOffset = -0.01
        hair01.leftOffset = 0.18
        hair01.rightOffset = 0.40
        hairImageOffsetArray.append(hair01)
        
        let hair02 = HairImageOffsetObject()
        hair02.imageName = "hair_02.png"
        hair02.topOffset = 0.12
        hair02.leftOffset = -0.02
        hair02.rightOffset = 0.51
        hairImageOffsetArray.append(hair02)
        
        let hair03 = HairImageOffsetObject()
        hair03.imageName = "hair_03.png"
        hair03.topOffset = 0.00
        hair03.leftOffset = 0.00
        hair03.rightOffset = 0.55
        hairImageOffsetArray.append(hair03)
        
        let hair04 = HairImageOffsetObject()
        hair04.imageName = "hair_04.png"
        hair04.topOffset = 0.26
        hair04.leftOffset = -0.01
        hair04.rightOffset = 0.30
        hairImageOffsetArray.append(hair04)
        
        let hair05 = HairImageOffsetObject()
        hair05.imageName = "hair_05.png"
        hair05.topOffset = 0.26
        hair05.leftOffset = -0.02
        hair05.rightOffset = 0.34
        hairImageOffsetArray.append(hair05)
        
        let hair06 = HairImageOffsetObject()
        hair06.imageName = "hair_06.png"
        hair06.topOffset = 0.23
        hair06.leftOffset = 0.00
        hair06.rightOffset = 0.37
        hairImageOffsetArray.append(hair06)
        
        takePhotoBtn.addTargetClosure { (sender) in
            self.takePhotoBtnClick()
        }
        
        pickPhotoBtn.addTargetClosure { (sender) in
            self.pickPhotoBtnClick()
        }
        
    }
    
    func takePhotoBtnClick() {
        
        let xyyximagePicker = UIImagePickerController()
        xyyximagePicker.delegate = self
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            return
        }
        
        xyyximagePicker.allowsEditing = false
        xyyximagePicker.sourceType = .camera
        
        present(xyyximagePicker, animated: true, completion: nil)
        
    }
    
    func pickPhotoBtnClick() {
        
        let xyyximagePicker = UIImagePickerController()
        xyyximagePicker.delegate = self
        
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        
        xyyximagePicker.allowsEditing = false
        xyyximagePicker.sourceType = .photoLibrary
        
        present(xyyximagePicker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let sourceImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            if faceBoxView != nil {
                faceBoxView!.removeFromSuperview()
                faceBoxView = nil
            }
            
            changeHairBtn.addTargetClosure { (sender) in
                
            }
            
            personalImageView.image = sourceImage
            dismiss(animated: true) {
                self.pickedImage = sourceImage
                self.process(self.pickedImage)
            }
            
        } else {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func process(_ image: UIImage) {
        
        var orientation:UInt32 = 0
        switch image.imageOrientation {
        case .up:
            orientation = 1
        case .right:
            orientation = 6
        case .down:
            orientation = 3
        case .left:
            orientation = 8
        default:
            orientation = 1
        }
        
        // vision
        
        let faceLandmarksRequest = VNDetectFaceLandmarksRequest(completionHandler: self.handleFaceFeatures)
        let requestHandler = VNImageRequestHandler(cgImage: image.cgImage!, orientation: CGImagePropertyOrientation(rawValue: orientation)! ,options: [:])
        do {
            try requestHandler.perform([faceLandmarksRequest])
        } catch {
            print(error)
        }
    }
    
    func handleFaceFeatures(request: VNRequest, errror: Error?) {
        
        guard let faceObservations = request.results as? [VNFaceObservation] else {
            fatalError("unexpected result type!")
        }
        
        if faceBoxView != nil {
            faceBoxView!.removeFromSuperview()
            faceBoxView = nil
        }
        
        if (faceObservations.count > 1) {
            
            let alertController = UIAlertController(title: "人数",
                                                    message: "照片中不只一个人脸", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "关闭", style: .default, handler: {
                action in
                self.navigationController?.popViewController(animated: true)
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else if (faceObservations.count < 1) {
            
            let alertController = UIAlertController(title: "人数",
                                                    message: "照片中辨识不到人脸", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "关闭", style: .default, handler: {
                action in
                self.navigationController?.popViewController(animated: true)
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            let face = faceObservations[0]
            
            let imageViewWidth = personalImageView.frame.width
            let imageViewHeight = personalImageView.frame.height
            
            let imageWidth = pickedImage!.size.width
            let imageHeigh = pickedImage!.size.height
            
            var imageOriginX:CGFloat = 0
            var imageOriginY:CGFloat = 0
            var scale:CGFloat = 1
            if (personalImageView.contentMode == .scaleAspectFit) {
                if (imageWidth*imageViewHeight/imageViewWidth > imageHeigh) {
                    // width max
                    scale = imageViewWidth / imageWidth
                    let tempHeight = imageHeigh * scale
                    imageOriginY = (imageViewHeight - tempHeight) / 2
                    
                } else {
                    // height max
                    scale = imageViewHeight / imageHeigh
                    let tempWidth = imageWidth * scale
                    imageOriginX = (imageViewWidth - tempWidth) / 2
                    
                }
            } else if (personalImageView.contentMode == .scaleAspectFill) {
                if (imageWidth*imageViewHeight/imageViewWidth > imageHeigh) {
                    // width max
                    scale = imageViewHeight / imageHeigh
                    let tempWidth = imageWidth * scale
                    imageOriginX = (imageViewWidth - tempWidth) / 2
                    
                } else {
                    // height max
                    scale = imageViewWidth / imageWidth
                    let tempHeight = imageHeigh * scale
                    imageOriginY = (imageViewHeight - tempHeight) / 2
                    
                }
            }
            
            // the face rect
            let faceWith = face.boundingBox.size.width * pickedImage!.size.width * scale
            let faceHeigh = face.boundingBox.size.height * pickedImage!.size.height * scale
            let faceX = face.boundingBox.origin.x * pickedImage!.size.width * scale + imageOriginX
            let faceY = (1.0 - face.boundingBox.origin.y - face.boundingBox.size.height) * pickedImage!.size.height * scale + imageOriginY
            
            var leftContourPoint:CGPoint = CGPoint(x: 0, y: 0)
            var rightContourPoint:CGPoint = CGPoint(x: 0, y: 0)
            if (face.landmarks?.faceContour?.pointCount != nil ) {
                if (face.landmarks!.faceContour!.pointCount > 0) {
                    leftContourPoint = CGPoint(x: faceX + face.landmarks!.faceContour!.normalizedPoints[0].x * faceWith, y: faceY + (1.0 - face.landmarks!.faceContour!.normalizedPoints[0].y) * faceHeigh)
                    
                    rightContourPoint = CGPoint(x: faceX + face.landmarks!.faceContour!.normalizedPoints[face.landmarks!.faceContour!.pointCount - 1].x * faceWith, y: faceY + (1.0 - face.landmarks!.faceContour!.normalizedPoints[face.landmarks!.faceContour!.pointCount - 1].y) * faceHeigh)
                    
                }
            }
            
            // left eye
            var leftEyeCenterX:CGFloat = 0
            var leftEyeCenterY:CGFloat = 0
            if (face.landmarks?.leftEye?.pointCount != nil ) {
                
                var leftL:CGFloat = 1
                var leftR:CGFloat = 0
                var leftU:CGFloat = 1
                var leftD:CGFloat = 0
                
                for i in 0..<face.landmarks!.leftEye!.pointCount {
                    if (face.landmarks!.leftEye!.normalizedPoints[i].x < leftL) {
                        leftL = face.landmarks!.leftEye!.normalizedPoints[i].x
                    }
                    if (face.landmarks!.leftEye!.normalizedPoints[i].x > leftR) {
                        leftR = face.landmarks!.leftEye!.normalizedPoints[i].x
                    }
                    if ((1.0 - face.landmarks!.leftEye!.normalizedPoints[i].y) < leftU) {
                        leftU = 1.0 - face.landmarks!.leftEye!.normalizedPoints[i].y
                    }
                    if ((1.0 - face.landmarks!.leftEye!.normalizedPoints[i].y) > leftD) {
                        leftD = 1.0 - face.landmarks!.leftEye!.normalizedPoints[i].y
                    }
                }
                
                if (leftL != 1 && leftR != 0) {
                    leftEyeCenterX = faceX + (leftL + leftR) / 2 * faceWith
                }
                if (leftU != 1 && leftD != 0) {
                    leftEyeCenterY = faceY + (leftU + leftD) / 2 * faceHeigh
                }
            }
            
            // right eye
            var rightEyeCenterX:CGFloat = 0
            var rightEyeCenterY:CGFloat = 0
            if (face.landmarks?.rightEye?.pointCount != nil ) {
                
                var rightL:CGFloat = 1
                var rightR:CGFloat = 0
                var rightU:CGFloat = 1
                var rightD:CGFloat = 0
                
                for i in 0..<face.landmarks!.rightEye!.pointCount {
                    if (face.landmarks!.rightEye!.normalizedPoints[i].x < rightL) {
                        rightL = face.landmarks!.rightEye!.normalizedPoints[i].x
                    }
                    if (face.landmarks!.rightEye!.normalizedPoints[i].x > rightR) {
                        rightR = face.landmarks!.rightEye!.normalizedPoints[i].x
                    }
                    if ((1.0 - face.landmarks!.rightEye!.normalizedPoints[i].y) < rightU) {
                        rightU = 1.0 - face.landmarks!.rightEye!.normalizedPoints[i].y
                    }
                    if ((1.0 - face.landmarks!.rightEye!.normalizedPoints[i].y) > rightD) {
                        rightD = 1.0 - face.landmarks!.rightEye!.normalizedPoints[i].y
                    }
                }
                
                if (rightL != 1 && rightR != 0) {
                    rightEyeCenterX = faceX + (rightL + rightR) / 2 * faceWith
                }
                if (rightU != 1 && rightD != 0) {
                    rightEyeCenterY = faceY + (rightU + rightD) / 2 * faceHeigh
                }
                
            }
            
            let leftRange:CGFloat = calculateDistance(from: leftContourPoint, to: CGPoint(x: leftEyeCenterX, y: leftEyeCenterY)) * 0.9
            let rightRange:CGFloat = calculateDistance(from: CGPoint(x: rightEyeCenterX, y: rightEyeCenterY), to: rightContourPoint) * 0.9
            
            
            var isFront = true
            
//            if #available(iOS 12.0, *) {
//
//                if let yaw = face.yaw {
//                    if (abs(yaw.floatValue) > 0.1) {
//                        isFront = false
//                    }
//                }
//
//            } else {
//
//                if (abs(leftRange - rightRange) > max(leftRange,rightRange)*0.1) {
//                    isFront = false
//                }
//            }
            
            
            if (abs(leftRange - rightRange) > max(leftRange,rightRange)*0.2) {
                isFront = false
            }
            
            
//            if #available(iOS 12.0, *) {
//
//                print("face roll \(String(describing: face.roll))")
//                if let roll = face.roll {
//                    if (abs(roll.floatValue) > 0.1) {
//                        isFront = false
//                    }
//                }
//
//            } else {
//
//                let mainDegree = calculateDegree(from: CGPoint(x: leftEyeCenterX,y: leftEyeCenterY), to: CGPoint(x: rightEyeCenterX,y: rightEyeCenterY))
//                let leftDegree = calculateDegree(from: leftContourPoint, to: CGPoint(x: leftEyeCenterX,y: leftEyeCenterY))
//                let rightDegree = calculateDegree(from: CGPoint(x: rightEyeCenterX,y: rightEyeCenterY), to: rightContourPoint)
//                if abs(leftDegree - mainDegree - 4) > 9 {
//                    isFront = false
//                }
//                if abs(rightDegree - mainDegree + 4) > 9 {
//                    isFront = false
//                }
//
//            }
            
            
            let mainDegree = calculateDegree(from: CGPoint(x: leftEyeCenterX,y: leftEyeCenterY), to: CGPoint(x: rightEyeCenterX,y: rightEyeCenterY))
            let leftDegree = calculateDegree(from: leftContourPoint, to: CGPoint(x: leftEyeCenterX,y: leftEyeCenterY))
            let rightDegree = calculateDegree(from: CGPoint(x: rightEyeCenterX,y: rightEyeCenterY), to: rightContourPoint)
            if (abs((leftDegree+rightDegree)/2-mainDegree) - 2.4) > 9 {
                isFront = false
            }
            
            
            
            if (!isFront) {
                
                let alertController = UIAlertController(title: "正面照",
                                                        message: "请使用正面照片", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "关闭", style: .default, handler: {
                    action in
                    self.navigationController?.popViewController(animated: true)
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                
                let mainLeftX = leftEyeCenterX - leftRange*cos(calculateDegree(from: CGPoint(x: leftEyeCenterX,y: leftEyeCenterY), to: CGPoint(x: rightEyeCenterX,y: rightEyeCenterY))*CGFloat.pi/180)
                
                let mainLeftY = leftEyeCenterY + leftRange*sin(calculateDegree(from: CGPoint(x: leftEyeCenterX,y: leftEyeCenterY), to: CGPoint(x: rightEyeCenterX,y: rightEyeCenterY))*CGFloat.pi/180)
                
                let mainRightX = rightEyeCenterX + rightRange*cos(calculateDegree(from: CGPoint(x: leftEyeCenterX,y: leftEyeCenterY), to: CGPoint(x: rightEyeCenterX,y: rightEyeCenterY))*CGFloat.pi/180)
                
                let mainRightY = rightEyeCenterY - rightRange*sin(calculateDegree(from: CGPoint(x: leftEyeCenterX,y: leftEyeCenterY), to: CGPoint(x: rightEyeCenterX,y: rightEyeCenterY))*CGFloat.pi/180)
                
                currentHairIndex = 1
                
                let widthScale:CGFloat = 1.0 - self.hairImageOffsetArray[currentHairIndex].rightOffset - self.hairImageOffsetArray[currentHairIndex].leftOffset
                
                let hairImage = UIImage(named: self.hairImageOffsetArray[currentHairIndex].imageName)
                let displayDistance = calculateDistance(from: CGPoint(x: mainLeftX,y: mainLeftY), to: CGPoint(x: mainRightX,y: mainRightY))
                let displayImageWidth = displayDistance / widthScale
                let displayImageHeight = displayImageWidth * hairImage!.size.height / hairImage!.size.width
                let topOffsetDistance = displayImageHeight * self.hairImageOffsetArray[currentHairIndex].topOffset
                let startCenterX = mainLeftX + (mainRightX - mainLeftX) * (widthScale - self.hairImageOffsetArray[currentHairIndex].leftOffset + self.hairImageOffsetArray[currentHairIndex].rightOffset) / 2
                let startCenterY = mainLeftY + (mainRightY - mainLeftY) * (widthScale - self.hairImageOffsetArray[currentHairIndex].leftOffset + self.hairImageOffsetArray[currentHairIndex].rightOffset) / 2
                let displayImageCenterX = startCenterX - topOffsetDistance*cos((calculateDegree(from: CGPoint(x: leftEyeCenterX,y: leftEyeCenterY), to: CGPoint(x: rightEyeCenterX,y: rightEyeCenterY))-90)*CGFloat.pi/180)
                let displayImageCenterY = startCenterY + topOffsetDistance*sin((calculateDegree(from: CGPoint(x: leftEyeCenterX,y: leftEyeCenterY), to: CGPoint(x: rightEyeCenterX,y: rightEyeCenterY))-90)*CGFloat.pi/180)
                
                let hairBounds = CGRect(x: displayImageCenterX - displayImageWidth/2, y: displayImageCenterY - displayImageHeight/2, width: displayImageWidth, height: displayImageHeight)
                
                faceBoxView = UIImageView(frame: hairBounds)
                faceBoxView!.backgroundColor = UIColor.clear
                faceBoxView!.contentMode = .scaleAspectFill
                faceBoxView!.image = hairImage
                faceBoxView!.backgroundColor = UIColor.clear
                
                personalImageView.addSubview(faceBoxView!)
                
                faceBoxView!.transform = CGAffineTransform(rotationAngle: -calculateDegree(from: CGPoint(x: leftEyeCenterX,y: leftEyeCenterY), to: CGPoint(x: rightEyeCenterX,y: rightEyeCenterY)) * CGFloat.pi / 180);
                
                changeHairBtn.addTargetClosure { (sender) in
                    
                    self.currentHairIndex = self.currentHairIndex + 1
                    if self.currentHairIndex > 5 {
                        self.currentHairIndex = 0
                    }
                    
                    if self.faceBoxView != nil {
                        self.faceBoxView!.removeFromSuperview()
                        self.faceBoxView = nil
                    }
                    
                    let widthScale:CGFloat = 1.0 - self.hairImageOffsetArray[self.currentHairIndex].rightOffset - self.hairImageOffsetArray[self.currentHairIndex].leftOffset
                    
                    let hairImage = UIImage(named: self.hairImageOffsetArray[self.currentHairIndex].imageName)
                    let displayDistance = self.calculateDistance(from: CGPoint(x: mainLeftX,y: mainLeftY), to: CGPoint(x: mainRightX,y: mainRightY))
                    let displayImageWidth = displayDistance / widthScale
                    let displayImageHeight = displayImageWidth * hairImage!.size.height / hairImage!.size.width
                    let topOffsetDistance = displayImageHeight * self.hairImageOffsetArray[self.currentHairIndex].topOffset
                    let startCenterX = mainLeftX + (mainRightX - mainLeftX) * (widthScale - self.hairImageOffsetArray[self.currentHairIndex].leftOffset + self.hairImageOffsetArray[self.currentHairIndex].rightOffset) / 2
                    let startCenterY = mainLeftY + (mainRightY - mainLeftY) * (widthScale - self.hairImageOffsetArray[self.currentHairIndex].leftOffset + self.hairImageOffsetArray[self.currentHairIndex].rightOffset) / 2
                    let displayImageCenterX = startCenterX - topOffsetDistance*cos((self.calculateDegree(from: CGPoint(x: leftEyeCenterX,y: leftEyeCenterY), to: CGPoint(x: rightEyeCenterX,y: rightEyeCenterY))-90)*CGFloat.pi/180)
                    let displayImageCenterY = startCenterY + topOffsetDistance*sin((self.calculateDegree(from: CGPoint(x: leftEyeCenterX,y: leftEyeCenterY), to: CGPoint(x: rightEyeCenterX,y: rightEyeCenterY))-90)*CGFloat.pi/180)
                    
                    let hairBounds = CGRect(x: displayImageCenterX - displayImageWidth/2, y: displayImageCenterY - displayImageHeight/2, width: displayImageWidth, height: displayImageHeight)
                    
                    self.faceBoxView = UIImageView(frame: hairBounds)
                    self.faceBoxView!.backgroundColor = UIColor.clear
                    self.faceBoxView!.contentMode = .scaleAspectFill
                    self.faceBoxView!.image = hairImage
                    self.faceBoxView!.backgroundColor = UIColor.clear
                    self.personalImageView.addSubview(self.faceBoxView!)
                    
                    self.faceBoxView!.transform = CGAffineTransform(rotationAngle: -self.calculateDegree(from: CGPoint(x: leftEyeCenterX,y: leftEyeCenterY), to: CGPoint(x: rightEyeCenterX,y: rightEyeCenterY)) * CGFloat.pi / 180);
                    
                }

            }
            
        }
        
    }
    
    func calculateDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt((to.x - from.x) * (to.x - from.x) + (to.y - from.y) * (to.y - from.y))
    }
    
    func calculateDegree(from: CGPoint, to: CGPoint) -> CGFloat {
        let yForRads = to.y - from.y;
        let xForRads = from.x - to.x;
        return 180.0 * atan(yForRads/xForRads) / .pi
    }
    
    func requestPhotoAuth(abbx: String?, abby: String?) {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        if (photoAuthorizationStatus == .notDetermined) {
            PHPhotoLibrary.requestAuthorization { (authorizationStatus) in
                self.requestPhotoAuth(abbx: nil, abby: nil)
            }
        } else {
            if (photoAuthorizationStatus != .authorized) {
                
                let alertController = UIAlertController(title: "同意使用相簿",
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

