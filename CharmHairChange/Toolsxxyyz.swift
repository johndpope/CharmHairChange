
import Foundation
import UIKit
import CoreData
import Alamofire
import SendBirdSDK

func xyyxsendBirdInit(abbx: String?, abby: String?, sendBirdAppId: String) {
    SBDMain.initWithApplicationId(sendBirdAppId)
}

func xyyxsendMessageTo(abbx: String?, abby: String?, sendBirdChannelUrl:String, userId:String, messageDic:[String:Any], didSendCallback: @escaping (_ status:Bool) -> Void) {
    
    SBDMain.connect(withUserId: userId) { (user, error) in
        guard error == nil else {
            didSendCallback(false)
            return
        }
        SBDOpenChannel.getWithUrl(sendBirdChannelUrl) { (channel, error) in
            guard error == nil else {
                didSendCallback(false)
                return
            }
            do {
                let xyyxuploadData = try JSONSerialization.data(withJSONObject: messageDic, options: JSONSerialization.WritingOptions())
                let xyyxuploadString = String(data: xyyxuploadData, encoding: String.Encoding.utf8)
                channel?.enter(completionHandler: { (error) in
                    guard error == nil else {
                        didSendCallback(false)
                        return
                    }
                    channel?.sendUserMessage(xyyxuploadString, completionHandler: { (message, error) in
                        guard error == nil else {
                            didSendCallback(false)
                            return
                        }
                        channel?.exitChannel(completionHandler: { (error) in
                            guard error == nil else {
                                didSendCallback(false)
                                return
                            }
                            SBDMain.disconnect(completionHandler: {
                                didSendCallback(true)
                            })
                        })
                        
                    })
                    
                })
                
            } catch {
                didSendCallback(false)
            }
        }
    }
}

func xyyxgetMessagesFrom(abbx: String?, abby: String?, sendBirdChannelUrl:String, userId:String, numbersOfRange:UInt, didGetCallback:@escaping (_ messageArray:[Any]) -> Void) {
    
    SBDMain.connect(withUserId: userId) { (user, error) in
        guard error == nil else {
            didGetCallback([Any]())
            return
        }
        SBDOpenChannel.getWithUrl(sendBirdChannelUrl) { (channel, error) in
            guard error == nil else {
                didGetCallback([Any]())
                return
            }
            channel?.enter(completionHandler: { (error) in
                guard error == nil else {
                    didGetCallback([Any]())
                    return
                }
                
                let xyyxpageOfNumbers = UInt(100)
                let xyyxprevMessageListQuery = channel?.createPreviousMessageListQuery()
                xyyxprevMessageListQuery?.limit = xyyxpageOfNumbers
                xyyxprevMessageListQuery?.reverse = true
                
                if let xyyxlistQuery = xyyxprevMessageListQuery {
                    xyyxgetMessagesListQueryLoop(abbx: nil, abby: nil, counter: numbersOfRange, pageOfNumbers: xyyxpageOfNumbers, startArray: [Any](), listQuery: xyyxlistQuery, callback: { (messageArray) in
                        
                        channel?.exitChannel(completionHandler: { (error) in
                            guard error == nil else {
                                didGetCallback(messageArray)
                                return
                            }
                            SBDMain.disconnect(completionHandler: {
                                didGetCallback(messageArray)
                            })
                        })
                        
                    })
                } else {
                    didGetCallback([Any]())
                }
            })
            
        }
        
    }
    
}

private func xyyxgetMessagesListQueryLoop(abbx: String?, abby: String?, counter:UInt, pageOfNumbers:UInt, startArray:[Any], listQuery:SBDPreviousMessageListQuery, callback: @escaping ([Any]) -> Void) {
    
    var xyyxresponseArray = [Any]()
    for i in 0..<startArray.count {
        xyyxresponseArray.append(startArray[i])
    }
    listQuery.load(completionHandler: { (messages, error) in
        guard error == nil else {
            callback(xyyxresponseArray)
            return
        }
        
        if (messages != nil) {
            for i in 0..<messages!.count {
                if let xyyxuserMsg = messages![i] as? SBDUserMessage {
                    if let xyyxmsg = xyyxuserMsg.message {
                        if let xyyxmsgData = xyyxmsg.data(using: String.Encoding.utf8) {
                            
                            do {
                                if let xyyxmsgDic = try JSONSerialization.jsonObject(with: xyyxmsgData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any] {
                                    
                                    xyyxresponseArray.append(xyyxmsgDic)
                                    
                                }
                            } catch {}
                        }
                    }
                }
            }
        }
        
        if ((counter - pageOfNumbers) > 0) {
            xyyxgetMessagesListQueryLoop(abbx: nil, abby: nil, counter: counter - pageOfNumbers, pageOfNumbers: pageOfNumbers, startArray: xyyxresponseArray, listQuery: listQuery, callback: callback)
        } else {
            callback(xyyxresponseArray)
        }
        
    })
}

func xyyxgetSendBirdUserInfo(abbx: String?, abby: String?) -> UserInfoObjectxxyyz {
    
    let xyyxuserInfo = UserInfoObjectxxyyz()
    if let xyyxuserEmail = UserDefaults.standard.string(forKey: "userEmail") {
        xyyxuserInfo.xyyxuserEmail = xyyxuserEmail
    }
    if let xyyxuserPassword = UserDefaults.standard.string(forKey: "userPassword") {
        xyyxuserInfo.xyyxuserPassword = xyyxuserPassword
    }
    if let xyyxuserNickname = UserDefaults.standard.string(forKey: "userNickname") {
        xyyxuserInfo.xyyxuserNickname = xyyxuserNickname
    }
    if let xyyxuserImageUrl = UserDefaults.standard.string(forKey: "userImageUrl") {
        xyyxuserInfo.xyyxuserImageUrl = xyyxuserImageUrl
    }
    return xyyxuserInfo
}

func xyyxsetSendBirdUserInfo(abbx: String?, abby: String?, userNickname:String, userEmail:String, userImageUrl:String, userPassword:String) {
    UserDefaults.standard.set(userNickname, forKey: "userNickname")
    UserDefaults.standard.set(userEmail, forKey: "userEmail")
    UserDefaults.standard.set(userImageUrl, forKey: "userImageUrl")
    UserDefaults.standard.set(userPassword, forKey: "userPassword")
}

func xyyxsendAccountTo(abbx: String?, abby: String?, sendBirdAccountChannelUrl:String, userInfo: UserInfoObjectxxyyz, didSendCallback: @escaping () -> Void) {
    if (userInfo.xyyxuserNickname.count > 0) {
        if (userInfo.xyyxuserEmail.count > 0) {
            if (userInfo.xyyxuserImageUrl.count > 0) {
                if (userInfo.xyyxuserPassword.count > 0) {
                    var xyyxsendDic = [String:Any]()
                    xyyxsendDic["userNickname"] = userInfo.xyyxuserNickname
                    xyyxsendDic["userEmail"] = userInfo.xyyxuserEmail
                    xyyxsendDic["userPassword"] = userInfo.xyyxuserPassword
                    xyyxsendDic["userImageUrl"] = userInfo.xyyxuserImageUrl
                    xyyxsendMessageTo(abbx: nil, abby: nil, sendBirdChannelUrl: sendBirdAccountChannelUrl, userId: "Administrator", messageDic: xyyxsendDic) { (sendStatus) in
                        if (sendStatus) {
                            didSendCallback()
                        } else {
                            print("send account failure")
                        }
                    }
                }
            }
        }
    }
}

func xyyxgetAccountsFrom(abbx: String?, abby: String?, sendBirdAccountChannelUrl:String, didGetCallback: @escaping (_ userInfoArray:[UserInfoObjectxxyyz]) -> Void) {
    
    xyyxgetMessagesFrom(abbx: nil, abby: nil, sendBirdChannelUrl: sendBirdAccountChannelUrl, userId: "Administrator", numbersOfRange: 1000) { (accountArray) in
        
        var xyyxuserInfoArray = [UserInfoObjectxxyyz]()
        for i in 0..<accountArray.count {
            if let xyyxaccountDic = accountArray[i] as? [String:Any] {
                let xyyxuserInfo = UserInfoObjectxxyyz()
                if let xyyxuserEmail = xyyxaccountDic["userEmail"] as? String {
                    xyyxuserInfo.xyyxuserEmail = xyyxuserEmail
                }
                if let xyyxuserNickname = xyyxaccountDic["userNickname"] as? String {
                    xyyxuserInfo.xyyxuserNickname = xyyxuserNickname
                }
                if let xyyxuserImageUrl = xyyxaccountDic["userImageUrl"] as? String {
                    xyyxuserInfo.xyyxuserImageUrl = xyyxuserImageUrl
                }
                if let xyyxuserPassword = xyyxaccountDic["userPassword"] as? String {
                    xyyxuserInfo.xyyxuserPassword = xyyxuserPassword
                }
                xyyxuserInfoArray.append(xyyxuserInfo)
            }
        }
        
        didGetCallback(xyyxuserInfoArray)
        
    }
    
}

func xyyxsendDiscussTo(abbx: String?, abby: String?, sendBirdDiscussChannelUrl:String, discussObject:DiscussObjectxxyyz, didSendCallback: @escaping () -> Void) {
    
    var xyyxsendDic = [String:Any]()
    xyyxsendDic["discussId"] = discussObject.xyyxdiscussId
    xyyxsendDic["subject"] = discussObject.xyyxsubject
    xyyxsendDic["content"] = discussObject.xyyxcontent
    xyyxsendDic["date"] = discussObject.xyyxdate
    var xyyxaccordingDic = [String:Any]()
    xyyxaccordingDic["userEmail"] = discussObject.xyyxaccording.xyyxuserEmail
    xyyxaccordingDic["userNickname"] = discussObject.xyyxaccording.xyyxuserNickname
    xyyxaccordingDic["userImageUrl"] = discussObject.xyyxaccording.xyyxuserImageUrl
    xyyxaccordingDic["accordingUrl"] = discussObject.xyyxaccording.xyyxaccordingUrl
    xyyxaccordingDic["accordingImageUrl"] = discussObject.xyyxaccording.xyyxaccordingImageUrl
    xyyxaccordingDic["accordingTitle"] = discussObject.xyyxaccording.xyyxaccordingTitle
    xyyxaccordingDic["accordingSubTitle"] = discussObject.xyyxaccording.xyyxaccordingSubTitle
    xyyxsendDic["according"] = xyyxaccordingDic
    
    xyyxsendMessageTo(abbx: nil, abby: nil, sendBirdChannelUrl: sendBirdDiscussChannelUrl, userId: "Administrator", messageDic: xyyxsendDic) { (sendStatus) in
        if (sendStatus) {
            didSendCallback()
        } else {
            print("send discuss failure")
        }
    }
    
}

func xyyxgetDiscussesFrom(abbx: String?, abby: String?, sendBirdDiscussChannelUrl:String, didGetCallback: @escaping (_ discussArray:[DiscussObjectxxyyz]) -> Void) {
    
    xyyxgetMessagesFrom(abbx: nil, abby: nil, sendBirdChannelUrl: sendBirdDiscussChannelUrl, userId: "Administrator", numbersOfRange: 1000) { (resultArray) in
        
        var xyyxdiscussArray = [DiscussObjectxxyyz]()
        for i in 0..<resultArray.count {
            if let xyyxdiscussDic = resultArray[i] as? [String:Any] {
                let xyyxdiscussObj = DiscussObjectxxyyz()
                if let xyyxdiscussId = xyyxdiscussDic["discussId"] as? Int {
                    xyyxdiscussObj.xyyxdiscussId = xyyxdiscussId
                }
                if let xyyxsubject = xyyxdiscussDic["subject"] as? String {
                    xyyxdiscussObj.xyyxsubject = xyyxsubject
                }
                if let xyyxcontent = xyyxdiscussDic["content"] as? String {
                    xyyxdiscussObj.xyyxcontent = xyyxcontent
                }
                if let xyyxdate = xyyxdiscussDic["date"] as? String {
                    xyyxdiscussObj.xyyxdate = xyyxdate
                }
                if let xyyxaccordingDic = xyyxdiscussDic["according"] as? [String:Any] {
                    if let xyyxuserEmail = xyyxaccordingDic["userEmail"] as? String {
                        xyyxdiscussObj.xyyxaccording.xyyxuserEmail = xyyxuserEmail
                    }
                    if let xyyxuserNickname = xyyxaccordingDic["userNickname"] as? String {
                        xyyxdiscussObj.xyyxaccording.xyyxuserNickname = xyyxuserNickname
                    }
                    if let xyyxuserImageUrl = xyyxaccordingDic["userImageUrl"] as? String {
                        xyyxdiscussObj.xyyxaccording.xyyxuserImageUrl = xyyxuserImageUrl
                    }
                    if let xyyxaccordingUrl = xyyxaccordingDic["accordingUrl"] as? String {
                        xyyxdiscussObj.xyyxaccording.xyyxaccordingUrl = xyyxaccordingUrl
                    }
                    if let xyyxaccordingImageUrl = xyyxaccordingDic["accordingImageUrl"] as? String {
                        xyyxdiscussObj.xyyxaccording.xyyxaccordingImageUrl = xyyxaccordingImageUrl
                    }
                    if let xyyxaccordingTitle = xyyxaccordingDic["accordingTitle"] as? String {
                        xyyxdiscussObj.xyyxaccording.xyyxaccordingTitle = xyyxaccordingTitle
                    }
                    if let xyyxaccordingSubTitle = xyyxaccordingDic["accordingSubTitle"] as? String {
                        xyyxdiscussObj.xyyxaccording.xyyxaccordingSubTitle = xyyxaccordingSubTitle
                    }
                }
                xyyxdiscussArray.append(xyyxdiscussObj)
            }
        }
        
        didGetCallback(xyyxdiscussArray)
        
    }
    
}

func xyyxsendNewPageTo(abbx: String?, abby: String?, sendBirdNewPageChannelUrl:String, newPageObject:NewPageObjectxxyyz, didSendCallback: @escaping () -> Void) {
    
    var xyyxsendDic = [String:Any]()
    xyyxsendDic["userEmail"] = newPageObject.xyyxuserEmail
    xyyxsendDic["userNickname"] = newPageObject.xyyxuserNickname
    xyyxsendDic["userImageUrl"] = newPageObject.xyyxuserImageUrl
    xyyxsendDic["menuId"] = newPageObject.xyyxmenuId
    xyyxsendDic["pageUrl"] = newPageObject.xyyxpageUrl
    xyyxsendDic["cateName"] = newPageObject.xyyxcateName
    xyyxsendDic["titleName"] = newPageObject.xyyxtitleName
    xyyxsendDic["subTitleName"] = newPageObject.xyyxsubTitleName
    xyyxsendDic["imageUrl"] = newPageObject.xyyximageUrl
    xyyxsendDic["tagName"] = newPageObject.xyyxtagName
    xyyxsendDic["editTime"] = newPageObject.xyyxeditTime

    xyyxsendMessageTo(abbx: nil, abby: nil, sendBirdChannelUrl: sendBirdNewPageChannelUrl, userId: "Administrator", messageDic: xyyxsendDic) { (sendStatus) in
        if (sendStatus) {
            didSendCallback()
        } else {
            print("send new page failure")
        }
    }
    
}

func xyyxgetNewPagesFrom(abbx: String?, abby: String?, sendBirdNewPageChannelUrl:String, didGetCallback: @escaping (_ newPageArray:[NewPageObjectxxyyz]) -> Void) {
    
    xyyxgetMessagesFrom(abbx: nil, abby: nil, sendBirdChannelUrl: sendBirdNewPageChannelUrl, userId: "Administrator", numbersOfRange: 1000) { (resultArray) in
        
        var xyyxnewPageArray = [NewPageObjectxxyyz]()
        for i in 0..<resultArray.count {
            if let xyyxresultDic = resultArray[i] as? [String:Any] {
                let xyyxnewPage = NewPageObjectxxyyz()
                if let xyyxuserEmail = xyyxresultDic["userEmail"] as? String {
                    xyyxnewPage.xyyxuserEmail = xyyxuserEmail
                }
                if let xyyxuserNickname = xyyxresultDic["userNickname"] as? String {
                    xyyxnewPage.xyyxuserNickname = xyyxuserNickname
                }
                if let xyyxuserImageUrl = xyyxresultDic["userImageUrl"] as? String {
                    xyyxnewPage.xyyxuserImageUrl = xyyxuserImageUrl
                }
                if let xyyxmenuId = xyyxresultDic["menuId"] as? Int {
                    xyyxnewPage.xyyxmenuId = xyyxmenuId
                }
                if let xyyxpageUrl = xyyxresultDic["pageUrl"] as? String {
                    xyyxnewPage.xyyxpageUrl = xyyxpageUrl
                }
                if let xyyxcateName = xyyxresultDic["cateName"] as? String {
                    xyyxnewPage.xyyxcateName = xyyxcateName
                }
                if let xyyxtitleName = xyyxresultDic["titleName"] as? String {
                    xyyxnewPage.xyyxtitleName = xyyxtitleName
                }
                if let xyyxsubTitleName = xyyxresultDic["subTitleName"] as? String {
                    xyyxnewPage.xyyxsubTitleName = xyyxsubTitleName
                }
                if let xyyximageUrl = xyyxresultDic["imageUrl"] as? String {
                    xyyxnewPage.xyyximageUrl = xyyximageUrl
                }
                if let xyyxtagName = xyyxresultDic["tagName"] as? [String] {
                    xyyxnewPage.xyyxtagName = xyyxtagName
                }
                if let xyyxeditTime = xyyxresultDic["editTime"] as? String {
                    xyyxnewPage.xyyxeditTime = xyyxeditTime
                }
                
                xyyxnewPageArray.append(xyyxnewPage)
            }
        }
        
        didGetCallback(xyyxnewPageArray)
        
    }
    
}

func xyyxsendUserAttentionTo(abbx: String?, abby: String?, sendBirdAttentionChannelUrl:String, attentionObject:AttentionObjectxxyyz, didSendCallback: @escaping () -> Void) {
    
    var xyyxsendDic = [String:Any]()
    xyyxsendDic["userEmail"] = attentionObject.xyyxuserEmail
    xyyxsendDic["userNickname"] = attentionObject.xyyxuserNickname
    xyyxsendDic["userImageUrl"] = attentionObject.xyyxuserImageUrl
    xyyxsendDic["accordingUrlArray"] = attentionObject.xyyxaccordingUrlArray
    
    xyyxsendMessageTo(abbx: nil, abby: nil, sendBirdChannelUrl: sendBirdAttentionChannelUrl, userId: "Administrator", messageDic: xyyxsendDic) { (sendStatus) in
        if (sendStatus) {
            didSendCallback()
        } else {
            print("send new page failure")
        }
    }
    
}

func xyyxgetUserAttentionsFrom(abbx: String?, abby: String?, sendBirdAttentionChannelUrl:String, didGetCallback: @escaping (_ attentionArray:[AttentionObjectxxyyz]) -> Void) {
    
    xyyxgetMessagesFrom(abbx: nil, abby: nil, sendBirdChannelUrl: sendBirdAttentionChannelUrl, userId: "Administrator", numbersOfRange: 1000) { (resultArray) in
        
        var xyyxattentionArray = [AttentionObjectxxyyz]()
        for i in 0..<resultArray.count {
            if let xyyxresultDic = resultArray[i] as? [String:Any] {
                let xyyxattention = AttentionObjectxxyyz()
                if let xyyxuserEmail = xyyxresultDic["userEmail"] as? String {
                    xyyxattention.xyyxuserEmail = xyyxuserEmail
                }
                if let xyyxuserNickname = xyyxresultDic["userNickname"] as? String {
                    xyyxattention.xyyxuserNickname = xyyxuserNickname
                }
                if let xyyxuserImageUrl = xyyxresultDic["userImageUrl"] as? String {
                    xyyxattention.xyyxuserImageUrl = xyyxuserImageUrl
                }
                if let xyyxaccordingUrlArray = xyyxresultDic["accordingUrlArray"] as? [String] {
                    xyyxattention.xyyxaccordingUrlArray = xyyxaccordingUrlArray
                }
                xyyxattentionArray.append(xyyxattention)
            }
        }
        
        didGetCallback(xyyxattentionArray)
        
    }
    
}

func xyyxsendRepostTo(abbx: String?, abby: String?, sendBirdRepostChannelUrl:String, repostObject:DiscussRepostObjectxxyyz, didSendCallback: @escaping () -> Void) {
    
    var xyyxsendDic = [String:Any]()
    xyyxsendDic["discussId"] = repostObject.xyyxdiscussId
    xyyxsendDic["userNickname"] = repostObject.xyyxuserNickname
    xyyxsendDic["userEmail"] = repostObject.xyyxuserEmail
    xyyxsendDic["userImageUrl"] = repostObject.xyyxuserImageUrl
    xyyxsendDic["content"] = repostObject.xyyxcontent
    xyyxsendDic["date"] = repostObject.xyyxdate
    
    xyyxsendMessageTo(abbx: nil, abby: nil, sendBirdChannelUrl: sendBirdRepostChannelUrl, userId: "Administrator", messageDic: xyyxsendDic) { (sendStatus) in
        if (sendStatus) {
            didSendCallback()
        } else {
            print("send discuss failure")
        }
    }
    
}

func xyyxgetRepostsFrom(abbx: String?, abby: String?, sendBirdRepostChannelUrl:String, didGetCallback: @escaping (_ repostArray:[DiscussRepostObjectxxyyz]) -> Void) {
    
    xyyxgetMessagesFrom(abbx: nil, abby: nil, sendBirdChannelUrl: sendBirdRepostChannelUrl, userId: "Administrator", numbersOfRange: 1000) { (resultArray) in
        
        var xyyxrepostArray = [DiscussRepostObjectxxyyz]()
        for i in 0..<resultArray.count {
            if let xyyxresultDic = resultArray[i] as? [String:Any] {
                let xyyxrepost = DiscussRepostObjectxxyyz()
                if let xyyxdiscussId = xyyxresultDic["discussId"] as? Int {
                    xyyxrepost.xyyxdiscussId = xyyxdiscussId
                }
                if let xyyxuserEmail = xyyxresultDic["userEmail"] as? String {
                    xyyxrepost.xyyxuserEmail = xyyxuserEmail
                }
                if let xyyxuserNickname = xyyxresultDic["userNickname"] as? String {
                    xyyxrepost.xyyxuserNickname = xyyxuserNickname
                }
                if let xyyxuserImageUrl = xyyxresultDic["userImageUrl"] as? String {
                    xyyxrepost.xyyxuserImageUrl = xyyxuserImageUrl
                }
                if let xyyxcontent = xyyxresultDic["content"] as? String {
                    xyyxrepost.xyyxcontent = xyyxcontent
                }
                if let xyyxdate = xyyxresultDic["date"] as? String {
                    xyyxrepost.xyyxdate = xyyxdate
                }
                
                xyyxrepostArray.append(xyyxrepost)
            }
        }
        
        didGetCallback(xyyxrepostArray)
        
    }
    
}

func xyyxsendLikeTo(abbx: String?, abby: String?, sendBirdLikeChannelUrl:String, likeObject:DiscussLikeObjectxxyyz, didSendCallback: @escaping () -> Void) {
    
    var xyyxsendDic = [String:Any]()
    xyyxsendDic["discussId"] = likeObject.xyyxdiscussId
    var xyyxuserInfoArray = [Any]()
    for i in 0..<likeObject.xyyxuserInfoArray.count {
        var xyyxuserInfo = [String:Any]()
        xyyxuserInfo["userNickname"] = likeObject.xyyxuserInfoArray[i].xyyxuserNickname
        xyyxuserInfo["userEmail"] = likeObject.xyyxuserInfoArray[i].xyyxuserEmail
        xyyxuserInfo["userImageUrl"] = likeObject.xyyxuserInfoArray[i].xyyxuserImageUrl
        xyyxuserInfo["userPassword"] = likeObject.xyyxuserInfoArray[i].xyyxuserPassword
        xyyxuserInfoArray.append(xyyxuserInfo)
    }
    xyyxsendDic["userInfoArray"] = xyyxuserInfoArray
    xyyxsendMessageTo(abbx: nil, abby: nil, sendBirdChannelUrl: sendBirdLikeChannelUrl, userId: "Administrator", messageDic: xyyxsendDic) { (sendStatus) in
        if (sendStatus) {
            didSendCallback()
        } else {
            print("send discuss failure")
        }
    }
    
}

func xyyxgetLikesFrom(abbx: String?, abby: String?, sendBirdLikeChannelUrl:String, didGetCallback: @escaping (_ likeArray:[DiscussLikeObjectxxyyz]) -> Void) {
    
    xyyxgetMessagesFrom(abbx: nil, abby: nil, sendBirdChannelUrl: sendBirdLikeChannelUrl, userId: "Administrator", numbersOfRange: 1000) { (resultArray) in
        
        var xyyxlikeArray = [DiscussLikeObjectxxyyz]()
        for i in 0..<resultArray.count {
            if let xyyxresultDic = resultArray[i] as? [String:Any] {
                
                if let xyyxdiscussId = xyyxresultDic["discussId"] as? Int {
                    let xyyxisContains = xyyxlikeArray.contains(where: { (likeObj) -> Bool in
                        return likeObj.xyyxdiscussId == xyyxdiscussId
                    })
                    if (!xyyxisContains) {
                        
                        let xyyxlike = DiscussLikeObjectxxyyz()
                        xyyxlike.xyyxdiscussId = xyyxdiscussId
                        if let xyyxuserInfoArray = xyyxresultDic["userInfoArray"] as? [Any] {
                            var xyyxuserInfoObjArray = [UserInfoObjectxxyyz]()
                            for j in 0..<xyyxuserInfoArray.count {
                                if let xyyxuserInfoDic = xyyxuserInfoArray[j] as? [String:Any] {
                                    let xyyxuserInfoObj = UserInfoObjectxxyyz()
                                    if let xyyxuserNickname = xyyxuserInfoDic["userNickname"] as? String {
                                        xyyxuserInfoObj.xyyxuserNickname = xyyxuserNickname
                                    }
                                    if let xyyxuserNickname = xyyxuserInfoDic["userNickname"] as? String {
                                        xyyxuserInfoObj.xyyxuserNickname = xyyxuserNickname
                                    }
                                    if let xyyxuserNickname = xyyxuserInfoDic["userNickname"] as? String {
                                        xyyxuserInfoObj.xyyxuserNickname = xyyxuserNickname
                                    }
                                    if let xyyxuserNickname = xyyxuserInfoDic["userNickname"] as? String {
                                        xyyxuserInfoObj.xyyxuserNickname = xyyxuserNickname
                                    }
                                    xyyxuserInfoObjArray.append(xyyxuserInfoObj)
                                }
                            }
                            xyyxlike.xyyxuserInfoArray = xyyxuserInfoObjArray
                        }
                        xyyxlikeArray.append(xyyxlike)
                        
                    }
                    
                }
                
            }
        }
        
        didGetCallback(xyyxlikeArray)
        
    }
    
}

func xyyxgetOutermostView(abbx: String?, abby: String?, sourceView:UIView) -> UIView {
    var superView:UIView? = sourceView
    while (superView!.superview != nil) {
        superView = superView!.superview
    }
    return superView!
}

func xyyxgetViewOfAbsoluteFame(abbx: String?, abby: String?, sourceView:UIView) -> CGRect {
    
    var originX:CGFloat = 0
    var originY:CGFloat = 0
    originX = originX + sourceView.frame.origin.x
    originY = originY + sourceView.frame.origin.y
    var superView = sourceView.superview
    while (superView != nil) {
        if superView is UIScrollView {
            originY = originY - (superView as! UIScrollView).contentOffset.y
        }
        originX = originX + superView!.frame.origin.x
        originY = originY + superView!.frame.origin.y
        superView = superView!.superview
    }
    return CGRect(x: originX, y: originY, width: sourceView.frame.size.width, height: sourceView.frame.size.height)
    
}

func xyyxstartIndicator(abbx: String?, abby: String?, currentVC:UIViewController, callback: @escaping (_ indicatorView:UIView?) -> Void) {
    
    if let onView = currentVC.view {
        DispatchQueue.main.async {
            
            let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            onView.addSubview(mainView)
            mainView.translatesAutoresizingMaskIntoConstraints = false
            mainView.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.75)
            
            onView.addConstraints([NSLayoutConstraint(item: mainView,
                                                      attribute: .leading,
                                                      relatedBy: .equal,
                                                      toItem: onView,
                                                      attribute: .leading,
                                                      multiplier: 1.0,
                                                      constant: 0.0),
                                   NSLayoutConstraint(item: mainView,
                                                      attribute: .trailing,
                                                      relatedBy: .equal,
                                                      toItem: onView,
                                                      attribute: .trailing,
                                                      multiplier: 1.0,
                                                      constant: 0.0),
                                   NSLayoutConstraint(item: mainView,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: onView,
                                                      attribute: .top,
                                                      multiplier: 1.0,
                                                      constant: 0.0),
                                   NSLayoutConstraint(item: mainView,
                                                      attribute: .bottom,
                                                      relatedBy: .equal,
                                                      toItem: onView,
                                                      attribute: .bottom,
                                                      multiplier: 1.0,
                                                      constant: 0.0)])
            
            let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            mainView.addSubview(indicator)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.backgroundColor = UIColor.clear
            indicator.style = UIActivityIndicatorView.Style.whiteLarge
            
            mainView.addConstraints([NSLayoutConstraint(item: indicator,
                                                        attribute: .centerX,
                                                        relatedBy: .equal,
                                                        toItem: mainView,
                                                        attribute: .centerX,
                                                        multiplier: 1.0,
                                                        constant: 0.0),
                                     NSLayoutConstraint(item: indicator,
                                                        attribute: .centerY,
                                                        relatedBy: .equal,
                                                        toItem: mainView,
                                                        attribute: .centerY,
                                                        multiplier: 1.0,
                                                        constant: 0.0)])
            
            indicator.startAnimating()
            
            callback(mainView)
            
        }
    } else {
        DispatchQueue.main.async {
            callback(nil)
        }
    }
    
}

func xyyxstopIndicator(abbx: String?, abby: String?, indicatorView:UIView?, callback: @escaping () -> Void) {
    DispatchQueue.main.async {
        if (indicatorView != nil) {
            indicatorView?.removeFromSuperview()
        }
        callback()
    }
}

func xyyxmatchPattern(abbx: String?, abby: String?, input: String, pattern:String) -> Bool {
    
    if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
        return regex.matches(in: input, options: [], range: NSMakeRange(0, (input as NSString).length)).count > 0
    } else {
        return false
    }
    
}

func xyyxresizeImageLimited(abbx: String?, abby: String?, image: UIImage, limitedSize: CGFloat) -> UIImage {
    
    let size = image.size
    if (size.width < limitedSize && size.height < limitedSize) {
        return image
    } else {
        var targetWidth:CGFloat = 0
        var targetHeight:CGFloat = 0
        if (size.width > size.height) {
            targetWidth = limitedSize
            targetHeight = limitedSize * size.height / size.width
        } else {
            targetHeight = limitedSize
            targetWidth = limitedSize * size.width / size.height
        }
        
        let newSize = CGSize(width: targetWidth, height: targetHeight)
        let rect = CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        var newImage = UIImage()
        if let newImageTemp = UIGraphicsGetImageFromCurrentImageContext() {
            newImage = newImageTemp
        }
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}

func xyyxbackToViewController(abbx: String?, abby: String?, currentVC:UIViewController, backToVC:String) {
    var pvc:UIViewController = currentVC
    while (pvc.presentingViewController != nil) {
        pvc = pvc.presentingViewController!
        if (String(describing: pvc) == backToVC) {
            break
        }
    }
    pvc.dismiss(animated: false, completion: nil)
}

func xyyxgetDeviceTokenFromUserDefaults(abbx: String?, abby: String?, callback: @escaping (_ deviceToken:String) -> Void) {
    if let deviceToken = UserDefaults.standard.string(forKey: "deviceToken") {
        DispatchQueue.main.async {
            callback(deviceToken)
        }
    } else {
        let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { timer in
            xyyxgetDeviceTokenFromUserDefaults(abbx: nil, abby: nil, callback: callback)
        })
    }
}

func xyyxsaveDeviceTokenToUserDefaults(abbx: String?, abby: String?, deviceToken:String, callback: @escaping (_ deviceToken:String) -> Void) {
    UserDefaults.standard.set(deviceToken, forKey: "deviceToken")
    DispatchQueue.main.async {
        callback(deviceToken)
    }
}

func xyyxgetCoreDataContext(abbx: String?, abby: String?, entityName:String, callback: @escaping (_ context:NSManagedObjectContext) -> Void) {
    
    let persistentContainer = NSPersistentContainer(name: entityName)
    persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        } else {
            callback(persistentContainer.viewContext)
        }
    })
    
}



func xyyxcoreDataExample(abbx: String?, abby: String?) {
    
    let persistentContainer = NSPersistentContainer(name: "DataBaseName")
    persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        } else {
            let context = persistentContainer.viewContext
            
            // save data
            let entity = NSEntityDescription.entity(forEntityName: "FormName", in: context)
            let newData = NSManagedObject(entity: entity!, insertInto: context)
            newData.setValue("dataConten", forKey: "dataName")
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
            
            // get data
            let getRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FormName")
            //request.predicate = NSPredicate(format: "age = %@", "12")
            do {
                let result = try context.fetch(getRequest)
                for data in result as! [NSManagedObject] {
                    print(data.value(forKey: "dataName") as! String)
                }
            } catch {
                print("Failed")
            }
            
            // update data
            let updateRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "FormName")
            updateRequest.predicate = NSPredicate(format: "dataName = %@", "dataConten")
            do {
                let updateDatas = try context.fetch(updateRequest)
                if let data = updateDatas[0] as? NSManagedObject {
                    data.setValue("dataConten", forKey: "dataName")
                    data.setValue("dataConten", forKey: "dataName")
                    try context.save()
                }
            } catch {
                print("Failed")
            }
            
            // delete data
            let deleteRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "FormName")
            deleteRequest.predicate = NSPredicate(format: "dataName = %@", "dataConten")
            do {
                let deleteDatas = try context.fetch(deleteRequest)
                if let data = deleteDatas[0] as? NSManagedObject {
                    context.delete(data)
                    try context.save()
                }
            } catch {
                print("Failed")
            }
            
        }
    })
    
}

func xyyxuploadImageGetLink(abbx: String?, abby: String?, image: UIImage, callback: @escaping (_ imageLink:String) -> Void) {
    
    let xyyxurlString = "https://api.imgur.com/3/image"
    let xyyxauthorization = "Client-ID dcf69b797f59023"
    let xyyxmashapeKey = "07e83c5b2e1d2127030c97206a629d969bc86bf4"
    
    let xyyxresizeImage = xyyxresizeImageLimited(abbx: nil, abby: nil, image: image, limitedSize: 1024)
    
    // 將圖片轉為 base64 字串
    let xyyximageData = xyyxresizeImage.pngData()!
    let xyyximageBase64 = xyyximageData.base64EncodedString()
    
    let xyyxheaders: HTTPHeaders = ["Authorization": xyyxauthorization, "X-Mashape-Key": xyyxmashapeKey]
    let xyyxparameters: Parameters = ["image": xyyximageBase64]
    Alamofire.request(xyyxurlString, method: .post, parameters: xyyxparameters, headers: xyyxheaders).responseJSON { response in
        guard response.result.isSuccess else {
            let errorMessage = response.result.error?.localizedDescription
            print(errorMessage!)
            return
        }
        guard let JSON = response.result.value as? [String: Any] else {
            print("JSON formate error")
            return
        }
        guard let success = JSON["success"] as? Bool,
            let data = JSON["data"] as? [String: Any] else {
                print("JSON formate error")
                return
        }
        if !success {
            let message = data["error"] as? String ?? "error"
            print(message)
            return
        }
        if let link = data["link"] as? String,
            let _ = data["width"] as? Int,
            let _ = data["height"] as? Int {
            
            callback(link)
            
        }
    }
    
}

func xyyxgetDownArrow(abbx: String?, abby: String?, imageSize:CGFloat, color:UIColor) -> UIImage {
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: imageSize, height: imageSize), false, 0)
    let ctx = UIGraphicsGetCurrentContext()!
    ctx.beginPath()
    ctx.move(to: CGPoint(x: 0.0, y: 0.0))
    ctx.addLine(to: CGPoint(x: imageSize, y: 0.0))
    ctx.addLine(to: CGPoint(x: imageSize / 2, y: imageSize))
    ctx.closePath()
    ctx.setFillColor(color.cgColor)
    ctx.fillPath()
    let img = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return img
    
}

func xyyxisSameUrl(abbx: String?, abby: String?, urlx:String, urly:String) -> Bool {
    
    var purex = ""
    var purey = ""
    
    if let lastChar = urlx.last {
        if (lastChar == "/") {
            purex = String(urlx.prefix(urlx.count - 1))
        } else {
            purex = urlx
        }
    }
    if let lastChar = urly.last {
        if (lastChar == "/") {
            purey = String(urly.prefix(urly.count - 1))
        } else {
            purey = urly
        }
    }
    
    if (String(urlx.prefix(4)).lowercased() == "http") {
        if let firstCharIndex = urlx.firstIndex(of: ":") {
            purex = String(purex.suffix(purex.count - firstCharIndex.utf16Offset(in: urlx) - 3))
        }
    }
    if (String(urly.prefix(4)).lowercased() == "http") {
        if let firstCharIndex = urly.firstIndex(of: ":") {
            purey = String(purey.suffix(purey.count - firstCharIndex.utf16Offset(in: urly) - 3))
        }
    }
    if (purex == purey) {
        return true
    } else {
        return false
    }
    
}
