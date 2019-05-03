
import UIKit

class UserInfoTableViewxxyyz: UITableView, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var xyyxvcInstance:UserInfoViewControllerxxyyz?
    let xyyximagePicker = UIImagePickerController()
    var xyyxuserInfo = xyyxgetSendBirdUserInfo(abbx: nil, abby: nil)
    var xyyxdataArray = [String]()
    
    override func awakeFromNib() {
        xyyximagePicker.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return xyyxdataArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let xyyxcell = tableView.dequeueReusableCell(withIdentifier: "userInfoTVC", for: indexPath) as! UserInfoTableViewCellxxyyz
            
            xyyxcell.userImageIndicator.isHidden = true
            xyyxcell.userImageIndicator.stopAnimating()
            
            xyyxcell.tag = indexPath.row
            if (xyyxuserInfo.xyyxuserImageUrl.count > 0) {
                xyyxcell.userImageIndicator.startAnimating()
                xyyxcell.userImageIndicator.isHidden = false
                xyyxdownloadImage(abbx: nil, abby: nil, url: xyyxuserInfo.xyyxuserImageUrl) { (image) in
                    xyyxcell.userImageIndicator.isHidden = true
                    xyyxcell.userImageIndicator.stopAnimating()
                    if (xyyxcell.tag == indexPath.row) {
                        xyyxcell.userImageView.image = image
                    }
                }
            }
            
            xyyxcell.userNicknameLabel.text = xyyxuserInfo.xyyxuserNickname
            xyyxcell.userNicknameLabel.isHidden = false
            xyyxcell.userNicknameTextField.text = xyyxuserInfo.xyyxuserNickname
            xyyxcell.userNicknameTextField.isHidden = true
            xyyxcell.userEmailLabel.text = xyyxuserInfo.xyyxuserEmail
            xyyxcell.userEmailLabel.isHidden = false
            xyyxcell.userEmailTextField.text = xyyxuserInfo.xyyxuserEmail
            xyyxcell.userEmailTextField.isHidden = true
            
            xyyxcell.userNicknameBtn.setTitle("变更", for: UIControl.State.normal)
            xyyxcell.userNicknameBtn.addTargetClosure { (sender) in
                xyyxcell.userNicknameLabel.isHidden = true
                xyyxcell.userNicknameTextField.isHidden = false
                xyyxcell.userNicknameBtn.setTitle("储存", for: UIControl.State.normal)
                xyyxcell.userNicknameBtn.addTargetClosure { (sender) in
                    self.xyyxuserInfo.xyyxuserNickname = xyyxcell.userNicknameTextField.text!
                    xyyxsendAccountTo(abbx: nil, abby: nil, sendBirdAccountChannelUrl: xyyxappSendBirdAccountChannelUrl, userInfo: self.xyyxuserInfo, didSendCallback: {
                        self.reloadData()
                    })
                }
            }
            
            xyyxcell.userEmailBtn.setTitle("变更", for: UIControl.State.normal)
            xyyxcell.userEmailBtn.addTargetClosure { (sender) in
                xyyxcell.userEmailLabel.isHidden = true
                xyyxcell.userEmailTextField.isHidden = false
                xyyxcell.userEmailBtn.setTitle("储存", for: UIControl.State.normal)
                xyyxcell.userEmailBtn.addTargetClosure { (sender) in
                    self.xyyxuserInfo.xyyxuserEmail = xyyxcell.userEmailTextField.text!
                    xyyxsendAccountTo(abbx: nil, abby: nil, sendBirdAccountChannelUrl: xyyxappSendBirdAccountChannelUrl, userInfo: self.xyyxuserInfo, didSendCallback: {
                        self.reloadData()
                    })
                }
            }
            
            xyyxcell.userImageSelectBtn.addTargetClosure { (sender) in
                self.xyyximagePicker.allowsEditing = false
                self.xyyximagePicker.sourceType = .photoLibrary
                self.xyyxvcInstance!.present(self.xyyximagePicker, animated: true, completion: {
                    xyyxcell.userImageIndicator.startAnimating()
                    xyyxcell.userImageIndicator.isHidden = false
                })
                self.xyyxvcInstance!.present(self.xyyximagePicker, animated: true, completion: nil)
            }
            
            return xyyxcell
        } else {
            let xyyxcell = tableView.dequeueReusableCell(withIdentifier: "userInfoTVCS", for: indexPath) as! UserInfoTableViewCellSxxyyz
            
            
            return xyyxcell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let xyyxpickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            xyyxuploadImageGetLink(abbx: nil, abby: nil, image: xyyxpickedImage) { (imageLink) in
                self.xyyxuserInfo.xyyxuserImageUrl = imageLink
                xyyxsendAccountTo(abbx: nil, abby: nil, sendBirdAccountChannelUrl: xyyxappSendBirdAccountChannelUrl, userInfo: self.xyyxuserInfo, didSendCallback: {
                    self.reloadData()
                })
            }
            
        }
        
        self.xyyximagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.xyyximagePicker.dismiss(animated: true, completion: nil)
        
    }

}
