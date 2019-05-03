import UIKit

class RepostDiscussViewControllerxxyyz: KeyboardViewControllerxxyyz, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var repostTV: UITableView!
    @IBOutlet weak var sendView: UIView!
    @IBOutlet weak var sendTextField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    var xyyxsendBirdDiscussChannelUrl:String = ""
    var xyyxsendBirdRepostChannelUrl:String = ""
    var xyyxdiscussId:Int = 0
    var xyyxuserInfo:UserInfoObjectxxyyz = UserInfoObjectxxyyz()
    var xyyxdiscussObject:DiscussObjectxxyyz = DiscussObjectxxyyz()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendTextField.delegate = self
        
        repostTV.dataSource = self
        repostTV.delegate = self
        repostTV.contentInset = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 5.0, right: 0.0)
        
        sendView.backgroundColor = xyyxappMainColor
        sendBtn.setTitleColor(xyyxappSubColor, for: UIControl.State.normal)
        sendBtn.addTarget(self, action: #selector(xyyxsendBtnClick), for: UIControl.Event.touchUpInside)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        xyyxstartIndicator(abbx: nil, abby: nil, currentVC: self) { (indicatorView) in
            self.xyyxresetData(abbx: nil, abby: nil, callback: {
                xyyxstopIndicator(abbx: nil, abby: nil, indicatorView: indicatorView, callback: {
                    
                })
            })
        }
    }
    
    func xyyxresetData(abbx: String?, abby: String?, callback: @escaping () -> Void) {
        var xyyxdiscussObjectTemp = DiscussObjectxxyyz()
        xyyxgetDiscussesFrom(abbx: nil, abby: nil, sendBirdDiscussChannelUrl: xyyxsendBirdDiscussChannelUrl) { (discussArray) in
            let xyyxindexTemp = discussArray.firstIndex(where: { (discussObj) -> Bool in
                return discussObj.xyyxdiscussId == self.xyyxdiscussId
            })
            if let xyyxindex = xyyxindexTemp {
                xyyxdiscussObjectTemp = discussArray[xyyxindex]
            }
            xyyxgetRepostsFrom(abbx: nil, abby: nil, sendBirdRepostChannelUrl: self.xyyxsendBirdRepostChannelUrl, didGetCallback: { (repostArray) in
                for i in 0..<repostArray.count {
                    if (repostArray[i].xyyxdiscussId == xyyxdiscussObjectTemp.xyyxdiscussId) {
                        xyyxdiscussObjectTemp.xyyxrepostArray.append(repostArray[i])
                    }
                }
                self.xyyxdiscussObject = xyyxdiscussObjectTemp
                self.repostTV.reloadData()
                callback()
            })
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return xyyxdiscussObject.xyyxrepostArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row > 0) {
            let xyyxcell = tableView.dequeueReusableCell(withIdentifier: "repostDiscussTVCS", for: indexPath) as! RepostDiscussTableViewCellSxxyyz
            
            xyyxcell.senderNicknameLabel.text = xyyxdiscussObject.xyyxrepostArray[indexPath.row - 1].xyyxuserNickname
            xyyxcell.tag = indexPath.row - 1
            if (xyyxdiscussObject.xyyxrepostArray[indexPath.row - 1].xyyxuserImageUrl.count > 0) {
                xyyxcell.senderImageView.isHidden = false
                xyyxdownloadImage(abbx: nil, abby: nil, url: xyyxdiscussObject.xyyxrepostArray[indexPath.row - 1].xyyxuserImageUrl) { (image) in
                    if (xyyxcell.tag == (indexPath.row - 1)) {
                        xyyxcell.senderImageView.layer.cornerRadius = xyyxcell.senderImageView.frame.height / 2
                        xyyxcell.senderImageView.clipsToBounds = true
                        xyyxcell.senderImageView.image = image
                    }
                }
            } else {
                xyyxcell.senderImageView.isHidden = true
            }
            
            xyyxcell.contentLabel.text = xyyxdiscussObject.xyyxrepostArray[indexPath.row - 1].xyyxcontent
            xyyxcell.dateLabel.text = xyyxdiscussObject.xyyxrepostArray[indexPath.row - 1].xyyxdate
            
            return xyyxcell
        } else {
            let xyyxcell = tableView.dequeueReusableCell(withIdentifier: "repostDiscussTVCM", for: indexPath) as! RepostDiscussTableViewCellMxxyyz
            xyyxcell.senderNicknameLabel.text = xyyxdiscussObject.xyyxaccording.xyyxuserNickname
            xyyxcell.tag = indexPath.row
            if (xyyxdiscussObject.xyyxaccording.xyyxuserImageUrl.count > 0) {
                xyyxcell.senderImageView.isHidden = false
                xyyxdownloadImage(abbx: nil, abby: nil, url: xyyxdiscussObject.xyyxaccording.xyyxuserImageUrl) { (image) in
                    if (xyyxcell.tag == indexPath.row) {
                        xyyxcell.senderImageView.layer.cornerRadius = xyyxcell.senderImageView.frame.height / 2
                        xyyxcell.senderImageView.clipsToBounds = true
                        xyyxcell.senderImageView.image = image
                    }
                }
            } else {
                xyyxcell.senderImageView.isHidden = true
            }
            
            
            xyyxcell.subjectLabel.text = xyyxdiscussObject.xyyxsubject
            
            xyyxcell.accordingTitleLabel.text = xyyxdiscussObject.xyyxaccording.xyyxaccordingTitle
            xyyxcell.accordingSubTitleLabel.text = xyyxdiscussObject.xyyxaccording.xyyxaccordingSubTitle
            if (xyyxdiscussObject.xyyxaccording.xyyxaccordingImageUrl.count > 0) {
                xyyxcell.accordingImageView.isHidden = false
                xyyxdownloadImage(abbx: nil, abby: nil, url: xyyxdiscussObject.xyyxaccording.xyyxaccordingImageUrl) { (image) in
                    if (xyyxcell.tag == indexPath.row) {
                        xyyxcell.accordingImageView.layer.cornerRadius = xyyxcell.accordingImageView.frame.height / 2
                        xyyxcell.accordingImageView.clipsToBounds = true
                        xyyxcell.accordingImageView.image = image
                    }
                }
            } else {
                xyyxcell.accordingImageView.isHidden = true
            }
            
            xyyxcell.contentLabel.text = xyyxdiscussObject.xyyxcontent
            
            return xyyxcell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func xyyxsendBtnClick(sender:UIButton) {
        
        if (self.sendTextField.text!.count > 0) {
            
            xyyxstartIndicator(abbx: nil, abby: nil, currentVC: self) { (indicatorView) in
                let xyyxrepostObj = DiscussRepostObjectxxyyz()
                xyyxrepostObj.xyyxdiscussId = self.xyyxdiscussId
                xyyxrepostObj.xyyxuserEmail = self.xyyxuserInfo.xyyxuserEmail
                xyyxrepostObj.xyyxuserNickname = self.xyyxuserInfo.xyyxuserNickname
                xyyxrepostObj.xyyxuserImageUrl = self.xyyxuserInfo.xyyxuserImageUrl
                xyyxrepostObj.xyyxcontent = self.sendTextField.text!
                let xyyxdf = DateFormatter()
                xyyxdf.dateFormat = "yyyy-MM-dd"
                xyyxrepostObj.xyyxdate = xyyxdf.string(from: Date())
                
                xyyxsendRepostTo(abbx: nil, abby: nil, sendBirdRepostChannelUrl: self.xyyxsendBirdRepostChannelUrl, repostObject: xyyxrepostObj, didSendCallback: {
                    
                    self.sendTextField.text = ""
                    
                    self.xyyxresetData(abbx: nil, abby: nil, callback: {
                        xyyxstopIndicator(abbx: nil, abby: nil, indicatorView: indicatorView, callback: {
                            
                        })
                    })
                    
                })
            }
            
        }
        
    }
    
    func xyyxsetParameter(abbx: String?, abby: String?, sendBirdDiscussChannelUrl: String, sendBirdRepostChannelUrl: String, discussId:Int, userInfo:UserInfoObjectxxyyz) {
        self.xyyxsendBirdDiscussChannelUrl = sendBirdDiscussChannelUrl
        self.xyyxsendBirdRepostChannelUrl = sendBirdRepostChannelUrl
        self.xyyxdiscussId = discussId
        self.xyyxuserInfo = userInfo
    }
    
}
