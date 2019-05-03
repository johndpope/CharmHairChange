import UIKit

class QueryDiscussViewControllerxxyyz: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var discussTV: UITableView!
    
    var xyyxsendBirdDiscussChannelUrl:String = ""
    var xyyxsendBirdRepostChannelUrl:String = ""
    var xyyxsendBirdLikeChannelUrl:String = ""
    var xyyxuserInfo:UserInfoObjectxxyyz = UserInfoObjectxxyyz()
    var xyyxdiscussArray = [DiscussObjectxxyyz]()

    var xyyxaccordingClickCallback:((_ discuss:DiscussObjectxxyyz) -> Void)?
    var xyyxrepostClickCallback:((_ discuss:DiscussObjectxxyyz) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setToolbarHidden(true, animated: false)
        
        discussTV.dataSource = self
        discussTV.delegate = self
        discussTV.contentInset = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 5.0, right: 0.0)
        
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
        
        xyyxgetDiscussesFrom(abbx: nil, abby: nil, sendBirdDiscussChannelUrl: self.xyyxsendBirdDiscussChannelUrl) { (discussArray) in
            
            xyyxgetRepostsFrom(abbx: nil, abby: nil, sendBirdRepostChannelUrl: self.xyyxsendBirdRepostChannelUrl, didGetCallback: { (repostArray) in
                for i in 0..<repostArray.count {
                    let xyyxdiscussIndexTemp = discussArray.firstIndex(where: { (discussObj) -> Bool in
                        return discussObj.xyyxdiscussId == repostArray[i].xyyxdiscussId
                    })
                    if let xyyxdiscussIndex = xyyxdiscussIndexTemp {
                        discussArray[xyyxdiscussIndex].xyyxrepostArray.append(repostArray[i])
                    }
                }
                
                xyyxgetLikesFrom(abbx: nil, abby: nil, sendBirdLikeChannelUrl: self.xyyxsendBirdLikeChannelUrl, didGetCallback: { (likeArray) in
                    for j in 0..<likeArray.count {
                        let xyyxdiscussIndexTemp = discussArray.firstIndex(where: { (discussObj) -> Bool in
                            return discussObj.xyyxdiscussId == likeArray[j].xyyxdiscussId
                        })
                        if let xyyxdiscussIndex = xyyxdiscussIndexTemp {
                            discussArray[xyyxdiscussIndex].xyyxlike = likeArray[j]
                        }
                    }
                    
                    self.xyyxdiscussArray = discussArray
                    self.discussTV.reloadData()
                    callback()
                    
                })
            })
            
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return xyyxdiscussArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let xyyxcell = tableView.dequeueReusableCell(withIdentifier: "queryDiscussTVC", for: indexPath) as! QueryDiscussTableViewCellxxyyz
        
        xyyxcell.senderNicknameLabel.text = self.xyyxdiscussArray[indexPath.row].xyyxaccording.xyyxuserNickname
        xyyxcell.tag = indexPath.row
        if (self.xyyxdiscussArray[indexPath.row].xyyxaccording.xyyxuserImageUrl.count > 0) {
            xyyxcell.senderImageView.isHidden = false
            xyyxdownloadImage(abbx: nil, abby: nil, url: self.xyyxdiscussArray[indexPath.row].xyyxaccording.xyyxuserImageUrl) { (image) in
                if (xyyxcell.tag == indexPath.row) {
                    xyyxcell.senderImageView.layer.cornerRadius = xyyxcell.senderImageView.frame.height / 2
                    xyyxcell.senderImageView.clipsToBounds = true
                    xyyxcell.senderImageView.image = image
                }
            }
        } else {
            xyyxcell.senderImageView.isHidden = true
        }
        
        
        xyyxcell.subjectLabel.text = self.xyyxdiscussArray[indexPath.row].xyyxsubject
        
        xyyxcell.accordingTitleLabel.text = self.xyyxdiscussArray[indexPath.row].xyyxaccording.xyyxaccordingTitle
        xyyxcell.accordingSubTitleLabel.text = self.xyyxdiscussArray[indexPath.row].xyyxaccording.xyyxaccordingSubTitle
        if (self.xyyxdiscussArray[indexPath.row].xyyxaccording.xyyxaccordingImageUrl.count > 0) {
            xyyxcell.accordingImageView.isHidden = false
            xyyxdownloadImage(abbx: nil, abby: nil, url: self.xyyxdiscussArray[indexPath.row].xyyxaccording.xyyxaccordingImageUrl) { (image) in
                if (xyyxcell.tag == indexPath.row) {
                    xyyxcell.accordingImageView.layer.cornerRadius = xyyxcell.accordingImageView.frame.height / 2
                    xyyxcell.accordingImageView.clipsToBounds = true
                    xyyxcell.accordingImageView.image = image
                }
            }
        } else {
            xyyxcell.accordingImageView.isHidden = true
        }
        
        xyyxcell.contentLabel.text = self.xyyxdiscussArray[indexPath.row].xyyxcontent
        xyyxcell.dateLabel.text = self.xyyxdiscussArray[indexPath.row].xyyxdate
        
        xyyxcell.repostBtn.setTitle("留言 \(self.xyyxdiscussArray[indexPath.row].xyyxrepostArray.count)", for: UIControl.State.normal)
        xyyxcell.likeBtn.setTitle("赞 \(self.xyyxdiscussArray[indexPath.row].xyyxlike.xyyxuserInfoArray.count)", for: UIControl.State.normal)
        
        xyyxcell.accordingSelectBtn.tag = indexPath.row
        xyyxcell.accordingSelectBtn.addTarget(self, action: #selector(xyyxaccordingBtnClick), for: UIControl.Event.touchUpInside)
        xyyxcell.repostBtn.tag = indexPath.row
        xyyxcell.repostBtn.addTarget(self, action: #selector(xyyxrepostBtnClick), for: UIControl.Event.touchUpInside)
        xyyxcell.likeBtn.tag = indexPath.row
        xyyxcell.likeBtn.addTarget(self, action: #selector(xyyxlikeBtnClick), for: UIControl.Event.touchUpInside)
        
        xyyxcell.layoutIfNeeded()
            
        return xyyxcell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func xyyxaccordingBtnClick(sender:UIButton) {
        if (xyyxaccordingClickCallback != nil) {
            xyyxaccordingClickCallback!(self.xyyxdiscussArray[sender.tag])
        }
    }
    
    @objc func xyyxrepostBtnClick(sender:UIButton) {
        if (xyyxrepostClickCallback != nil) {
            xyyxrepostClickCallback!(self.xyyxdiscussArray[sender.tag])
        }
    }
    
    @objc func xyyxlikeBtnClick(sender:UIButton) {
        xyyxstartIndicator(abbx: nil, abby: nil, currentVC: self) { (indicatorView) in
            let xyyxisContains = self.xyyxdiscussArray[sender.tag].xyyxlike.xyyxuserInfoArray.contains { (userInfo) -> Bool in
                return userInfo.xyyxuserEmail == self.xyyxuserInfo.xyyxuserEmail
            }
            
            if (!xyyxisContains) {
                self.xyyxdiscussArray[sender.tag].xyyxlike.xyyxuserInfoArray.append(self.xyyxuserInfo)
                xyyxsendLikeTo(abbx: nil, abby: nil, sendBirdLikeChannelUrl: self.xyyxsendBirdLikeChannelUrl, likeObject: self.xyyxdiscussArray[sender.tag].xyyxlike) {
                    self.discussTV.reloadData()
                    xyyxstopIndicator(abbx: nil, abby: nil, indicatorView: indicatorView, callback: {
                        
                    })
                }
            } else {
                xyyxstopIndicator(abbx: nil, abby: nil, indicatorView: indicatorView, callback: {
                    
                })
            }
        }
        
    }
    
    
    func xyyxsetRepostCallback(abbx: String?, abby: String?, clickCallback: ((_ discuss:DiscussObjectxxyyz) -> Void)?) {
        self.xyyxrepostClickCallback = clickCallback
    }
    
    func xyyxsetParameter(abbx: String?, abby: String?, sendBirdDiscussChannelUrl: String, sendBirdRepostChannelUrl: String, sendBirdLikeChannelUrl: String, userInfo:UserInfoObjectxxyyz, accordingCallback: ((_ discuss:DiscussObjectxxyyz) -> Void)?, repostCallback: ((_ discuss:DiscussObjectxxyyz) -> Void)?) {
        self.xyyxsendBirdDiscussChannelUrl = sendBirdDiscussChannelUrl
        self.xyyxsendBirdRepostChannelUrl = sendBirdRepostChannelUrl
        self.xyyxsendBirdLikeChannelUrl = sendBirdLikeChannelUrl
        self.xyyxrepostClickCallback = repostCallback
        self.xyyxaccordingClickCallback = accordingCallback
    }

}
