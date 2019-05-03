import UIKit

class ViewControllerTableViewxxyyz: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var vcInstance:ViewControllerxxyyz?
    var allDataList:[NewPageObjectxxyyz] = [NewPageObjectxxyyz]()
    var cateDataList:[NewPageObjectxxyyz] = [NewPageObjectxxyyz]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cateDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewControllerTVC", for: indexPath) as! ViewControllerTableViewCellxxyyz
        
        
        cell.cateTitleNameLabel.text = self.cateDataList[indexPath.row].xyyxtitleName
        cell.cateSubTitleNameLabel.text = self.cateDataList[indexPath.row].xyyxsubTitleName
        
        cell.cateImageView.tag = indexPath.row
        xyyxdownloadImage(abbx: nil, abby: nil, url: self.cateDataList[indexPath.row].xyyximageUrl) { (image) in
            if (cell.cateImageView.tag == indexPath.row) {
                cell.cateImageView.image = image
            }
        }
        
        if (self.cateDataList[indexPath.row].xyyxisAttention) {
            cell.cateAttentionBtn.backgroundColor = cell.xyyxmainColor
            cell.cateAttentionBtn.layer.borderColor = cell.xyyxsubColor.cgColor
            cell.cateAttentionBtn.setTitleColor(cell.xyyxsubColor, for: UIControl.State.normal)
        } else {
            cell.cateAttentionBtn.backgroundColor = cell.xyyxsubColor
            cell.cateAttentionBtn.layer.borderColor = cell.xyyxmainColor.cgColor
            cell.cateAttentionBtn.setTitleColor(cell.xyyxmainColor, for: UIControl.State.normal)
        }
        
        cell.cateAttentionBtn.tag = indexPath.row
        cell.cateAttentionBtn.addTargetClosure { (sender) in
            
            if (self.vcInstance!.xyyxuserInfo.xyyxuserNickname.count > 0) {
                if (self.vcInstance!.xyyxuserInfo.xyyxuserEmail.count > 0) {
                    if (self.cateDataList[sender.tag].xyyxisAttention) {
                        
                        xyyxgetUserAttentionsFrom(abbx: nil, abby: nil, sendBirdAttentionChannelUrl: xyyxappSendBirdAttentionChannelUrl, didGetCallback: { (attentionArray) in
                            let indexTemp = attentionArray.firstIndex(where: { (attentionObj) -> Bool in
                                return attentionObj.xyyxuserEmail == self.vcInstance!.xyyxuserInfo.xyyxuserEmail
                            })
                            if let index = indexTemp {
                                let attIndexTemp = attentionArray[index].xyyxaccordingUrlArray.index(of: self.cateDataList[sender.tag].xyyxpageUrl)
                                if let attIndex = attIndexTemp {
                                    attentionArray[index].xyyxaccordingUrlArray.remove(at: attIndex)
                                    
                                    xyyxsendUserAttentionTo(abbx: nil, abby: nil, sendBirdAttentionChannelUrl: xyyxappSendBirdAttentionChannelUrl, attentionObject: attentionArray[index], didSendCallback: {
                                        
                                    })
                                    
                                }
                            }
                        })
                        
                        self.cateDataList[sender.tag].xyyxisAttention = false
                        if let cateIndex = self.allDataList.firstIndex(where: { (obj) -> Bool in
                            return obj.xyyxmenuId == self.cateDataList[sender.tag].xyyxmenuId
                        }) {
                            self.allDataList[cateIndex].xyyxisAttention = false
                        }
                        self.reloadData()
                        
                    } else {
                        
                        xyyxgetUserAttentionsFrom(abbx: nil, abby: nil, sendBirdAttentionChannelUrl: xyyxappSendBirdAttentionChannelUrl, didGetCallback: { (attentionArray) in
                            let indexTemp = attentionArray.firstIndex(where: { (attentionObj) -> Bool in
                                return attentionObj.xyyxuserEmail == self.vcInstance!.xyyxuserInfo.xyyxuserEmail
                            })
                            if let index = indexTemp {
                                attentionArray[index].xyyxaccordingUrlArray.append(self.cateDataList[sender.tag].xyyxpageUrl)
                                
                                xyyxsendUserAttentionTo(abbx: nil, abby: nil, sendBirdAttentionChannelUrl: xyyxappSendBirdAttentionChannelUrl, attentionObject: attentionArray[index], didSendCallback: {
                                    
                                })
                                
                            }
                        })
                        
                        self.cateDataList[sender.tag].xyyxisAttention = true
                        if let cateIndex = self.allDataList.firstIndex(where: { (obj) -> Bool in
                            return obj.xyyxmenuId == self.cateDataList[sender.tag].xyyxmenuId
                        }) {
                            self.allDataList[cateIndex].xyyxisAttention = true
                        }
                        self.reloadData()
                        
                    }
                    
                }
            }
            
        }
        
        cell.cateDetailBtn.tag = indexPath.row
        cell.cateDetailBtn.addTargetClosure { (sender) in
            
            let overWebVC = OverWebViewControllerxxyyz(abbx: nil, abby: nil, title: self.cateDataList[sender.tag].xyyxtitleName)
            UIApplication.shared.keyWindow?.rootViewController?.present(overWebVC, animated: true, completion: {
                
                overWebVC.xyyxloadMultiUrl(abbx: nil, abby: nil, urls: [self.cateDataList[sender.tag].xyyxpageUrl])
                
                
                
            })
            
        }
        
        cell.cateSelectBtn.tag = indexPath.row
        cell.cateSelectBtn.addTargetClosure { (sender) in
            
            let overWebVC = OverWebViewControllerxxyyz(abbx: nil, abby: nil, title: self.cateDataList[sender.tag].xyyxtitleName)
            UIApplication.shared.keyWindow?.rootViewController?.present(overWebVC, animated: true, completion: {
                
                overWebVC.xyyxloadMultiUrl(abbx: nil, abby: nil, urls: [self.cateDataList[sender.tag].xyyxpageUrl])
                
                
            })
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
