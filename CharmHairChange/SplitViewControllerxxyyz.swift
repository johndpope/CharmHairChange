import UIKit
import CoreData

class SplitViewControllerxxyyz: UISplitViewController {
    
    var xyyxtotalPageArray = [NewPageObjectxxyyz]()
    var xyyxtotalCateArray = [String]()
    var xyyxcounter:Int = 0
    
    var xyyxnaviVC:NavigationControllerxxyyz?
    var xyyxrootVC:RootViewControllerxxyyz?
    var xyyxdetailNavi:DetailNavigationControllerxxyyz?
    var xyyxdetailVC:ViewControllerxxyyz?
    var xyyxuserInfo:UserInfoObjectxxyyz = UserInfoObjectxxyyz()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        xyyxsendBirdInit(abbx: nil, abby: nil, sendBirdAppId: xyyxsendBirdAppKey)
        
        if let xyyxnaviVCTemp = self.viewControllers.first as? NavigationControllerxxyyz {
            xyyxnaviVC = xyyxnaviVCTemp
            if let xyyxrootVCTemp = xyyxnaviVC?.topViewController as? RootViewControllerxxyyz {
                xyyxrootVC = xyyxrootVCTemp
            }
        }
        
        if let xyyxdetailNaviTemp = self.viewControllers.last as? DetailNavigationControllerxxyyz {
            xyyxdetailNavi = xyyxdetailNaviTemp
            if let xyyxdetailVCTemp = xyyxdetailNavi?.topViewController as? ViewControllerxxyyz {
                xyyxdetailVC = xyyxdetailVCTemp
                
                xyyxdetailVC?.navigationItem.leftItemsSupplementBackButton = true
                xyyxdetailVC?.navigationItem.leftBarButtonItem = self.displayModeButtonItem
                
            }
        }
        
        self.xyyxresetData(abbx: nil, abby: nil) {
            
            if let xyyxvc = self.xyyxdetailVC {
                xyyxvc.xyyxshowFeatures(abbx: nil, abby: nil)
            }
            
            if let xyyxlang = NSLocale.preferredLanguages.first {
                xyyxdownloadJasonDataAsDictionary(abbx: nil, abby: nil, url: "http://47.75.131.189/proof_code/?code=\(xyyxlang)", type: "GET", headers: [String:String](), uploadDic: nil, callback: { (resultStatus, resultHeaders, resultDic, resultError) in
                    
                    if let xyyxisRecommend = resultDic["status"] as? Bool {
                        if (xyyxisRecommend) {
                            self.xyyxshowRecommend(abbx: nil, abby: nil, cancelCallback: {
                                self.xyyxcheckLogin(abbx: nil, abby: nil) { }
                            })
                        } else {
                            self.xyyxcheckLogin(abbx: nil, abby: nil) { }
                        }
                    } else {
                        self.xyyxcheckLogin(abbx: nil, abby: nil) { }
                    }
                    
                })
            } else {
                self.xyyxcheckLogin(abbx: nil, abby: nil) { }
            }
            
        }
        
    }
    
    func xyyxresetData(abbx: String?, abby: String?, callback: @escaping () -> Void) {
        
        self.xyyxcounter = 0
        let xyyxuserInfo = xyyxgetSendBirdUserInfo(abbx: nil, abby: nil)
        var xyyxtotalPageArrayTemp = [NewPageObjectxxyyz]()
        var xyyxtotalCateArrayTemp = [String]()
        
        xyyxgetNewPagesFrom(abbx: nil, abby: nil, sendBirdNewPageChannelUrl: xyyxappSendBirdNewPageChannelUrl) { (newPageArray) in
            
            for i in 0..<newPageArray.count {
                xyyxtotalPageArrayTemp.append(newPageArray[i])
            }
            
            for i in 0..<xyyxappCateId.count {
                
                xyyxdownloadJasonDataAsDictionary(abbx: nil, abby: nil, url: "http://wp.asopeixun.com/left_category_data?category_id=" + xyyxappCateId[i], type: "GET", headers: [String:String](), uploadDic: nil) { (runStatus, resultHeaders, resultDic, errorString) in
                    
                    if let xyyxresultArray = resultDic["list"] as? [Any] {
                        for j in 0..<xyyxresultArray.count {
                            if let xyyxdataDic = xyyxresultArray[j] as? [String:Any] {
                                
                                var xyyxcateName = ""
                                if let xyyxcateNameTemp = xyyxdataDic["title"] as? String {
                                    xyyxcateName = xyyxcateNameTemp
                                }
                                
                                print(xyyxcateName)
                                if (xyyxcateName.count > 0) {
                                    xyyxtotalCateArrayTemp.append(xyyxcateName)
                                }
                                if let xyyxdataArray = xyyxdataDic["list"] as? [Any] {
                                    
                                    for k in 0..<xyyxdataArray.count {
                                        
                                        if let xyyxcontentDic = xyyxdataArray[k] as? [String:Any] {
                                            
                                            let xyyxpageContentObj = NewPageObjectxxyyz()
                                            xyyxpageContentObj.xyyxcateName = xyyxcateName
                                            if let xyyxtitleName = xyyxcontentDic["title"] as? String {
                                                xyyxpageContentObj.xyyxtitleName = xyyxtitleName
                                            }
                                            if let xyyxsubName = xyyxcontentDic["subcatename"] as? String {
                                                xyyxpageContentObj.xyyxsubTitleName = xyyxsubName
                                            }
                                            if let xyyxid = xyyxcontentDic["ID"] as? Int {
                                                xyyxpageContentObj.xyyxmenuId = xyyxid
                                                xyyxpageContentObj.xyyxpageUrl = "http://wp.asopeixun.com/?p=\(xyyxid)"
                                            }
                                            if let xyyxeditTime = xyyxcontentDic["edittime"] as? String {
                                                xyyxpageContentObj.xyyxeditTime = xyyxeditTime
                                            }
                                            if let xyyximageUrl = xyyxcontentDic["thumb"] as? String {
                                                xyyxpageContentObj.xyyximageUrl = xyyximageUrl
                                            }
                                            if let xyyxtagString = xyyxcontentDic["tags"] as? String {
                                                let xyyxtagArray = xyyxtagString.components(separatedBy: ",")
                                                xyyxpageContentObj.xyyxtagName = xyyxtagArray
                                            }
                                            xyyxtotalPageArrayTemp.append(xyyxpageContentObj)
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    self.xyyxcounter = self.xyyxcounter + 1
                    if (self.xyyxcounter == xyyxappCateId.count) {
                        
                        if (xyyxuserInfo.xyyxuserEmail.count > 0) {
                            
                            xyyxgetUserAttentionsFrom(abbx: nil, abby: nil, sendBirdAttentionChannelUrl: xyyxappSendBirdAttentionChannelUrl, didGetCallback: { (attentionArray) in
                                
                                let xyyxindexTemp = attentionArray.firstIndex(where: { (attentionObj) -> Bool in
                                    return attentionObj.xyyxuserEmail == xyyxuserInfo.xyyxuserEmail
                                })
                                if let xyyxindex = xyyxindexTemp {
                                    for j in 0..<xyyxtotalPageArrayTemp.count {
                                        if (attentionArray[xyyxindex].xyyxaccordingUrlArray.contains(xyyxtotalPageArrayTemp[j].xyyxpageUrl)) {
                                            xyyxtotalPageArrayTemp[j].xyyxisAttention = true
                                        }
                                    }
                                }
                                
                                self.xyyxtotalPageArray = xyyxtotalPageArrayTemp
                                self.xyyxtotalCateArray = xyyxtotalCateArrayTemp
                                
                                self.xyyxresetRootViewData(abbx: nil, abby: nil) {
                                    
                                    self.xyyxresetDetailViewData(abbx: nil, abby: nil) {
                                        
                                        callback()
                                        
                                    }
                                    
                                }
                                
                            })
                            
                        } else {
                            
                            self.xyyxtotalPageArray = xyyxtotalPageArrayTemp
                            self.xyyxtotalCateArray = xyyxtotalCateArrayTemp
                            
                            self.xyyxresetRootViewData(abbx: nil, abby: nil) {
                                
                                self.xyyxresetDetailViewData(abbx: nil, abby: nil) {
                                    
                                    callback()
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                    }
                    
                }
            }
            
        }
        
        
    }
    
    func xyyxresetRootViewData(abbx: String?, abby: String?, callback: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.xyyxrootVC?.rootTV.xyyxrootViewDataArray = self.xyyxtotalCateArray
            self.xyyxrootVC?.rootTV.reloadData()
            callback()
        }
    }
    
    func xyyxresetDetailViewData(abbx: String?, abby: String?, callback: @escaping () -> Void) {
        
        DispatchQueue.main.async {
            self.xyyxdetailVC?.viewControllerTV.cateDataList = [NewPageObjectxxyyz]()
            self.xyyxdetailVC?.viewControllerTV.allDataList = self.xyyxtotalPageArray
            self.xyyxdetailVC?.viewControllerTV.reloadData()
            callback()
        }
    }
    
    func xyyxcheckLogin(abbx: String?, abby: String?, didLoginCallback: @escaping () -> Void) {
        
        self.xyyxuserInfo = xyyxgetSendBirdUserInfo(abbx: nil, abby: nil)
        if (self.xyyxuserInfo.xyyxuserEmail.count == 0) {
            
            let xyyxloginVC = UIStoryboard(name: "Tools", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! LoginViewControllerxxyyz
            
            xyyxloginVC.xyyxsetParameter(abbx: nil, abby: nil, sendBirdAccountChannelUrl: xyyxappSendBirdAccountChannelUrl, didLoginCallback: { (userInfo) in
                
                xyyxloginVC.dismiss(animated: true, completion: {
                    
                    didLoginCallback()
                    
                })
                
            }) {
                
                xyyxloginVC.dismiss(animated: true, completion: {
                    
                    let xyyxregisterVC = UIStoryboard(name: "Tools", bundle: nil).instantiateViewController(withIdentifier: "registerVC") as! RegisterViewControllerxxyyz
                    
                    xyyxregisterVC.xyyxsetParameter(abbx: nil, abby: nil, sendBirdLoginChannelUrl: xyyxappSendBirdAccountChannelUrl, didRegistedCallback: { (userInfo) in
                        xyyxregisterVC.dismiss(animated: true, completion: {
                            self.xyyxcheckLogin(abbx: nil, abby: nil, didLoginCallback: didLoginCallback)
                        })
                    }, cancelCallback: {
                        xyyxregisterVC.dismiss(animated: true, completion: {
                            self.xyyxcheckLogin(abbx: nil, abby: nil, didLoginCallback: didLoginCallback)
                        })
                    })
                    
                    UIApplication.shared.keyWindow?.rootViewController?.present(xyyxregisterVC, animated: true, completion: {
                        
                    })
                    
                })
                
            }
            
            UIApplication.shared.keyWindow?.rootViewController?.present(xyyxloginVC, animated: true, completion: {
                
            })
            
        }
        
    }
    
    func xyyxshowRecommend(abbx: String?, abby: String?, cancelCallback: (() -> Void)?) {
        
        var xyyxheaders:[String:String] = [String:String]()
        xyyxheaders["Content-Type"] = "application/json"
        xyyxheaders["X-LC-Id"] = xyyxleanCloudAppId
        xyyxheaders["X-LC-Key"] = xyyxleanCloudAppKey
        let xyyxmaintenanceUrl = "https://leancloud.cn:443/1.1/classes/\(xyyxleanCloudInfoTable)?where=%7B%22\(xyyxleanCloudInfoTableColumBool)%22%3Atrue%7D"
        xyyxdownloadJasonDataAsDictionary(abbx: nil, abby: nil, url: xyyxmaintenanceUrl, type: "GET", headers: xyyxheaders, uploadDic: nil) { (resultStatus, resultHeaders, resultDic, errorString) in
            
            if let xyyxfoodArray = resultDic["results"] as? [Any] {
                if (xyyxfoodArray.count > 0) {
                    
                    var xyyxtitleName = ""
                    if let xyyxfoodDic = xyyxfoodArray[0] as? [String:Any] {
                        if let xyyxtitleNameTemp = xyyxfoodDic[xyyxleanCloudInfoTableColumTitle] as? String {
                            xyyxtitleName = xyyxtitleNameTemp
                        }
                    }
                    
                    let xyyxoverWebVC = OverWebViewControllerxxyyz(abbx: nil, abby: nil, title: xyyxtitleName)
                    
                    xyyxoverWebVC.xyyxsetCancelCallback(abbx: nil, abby: nil, cancelCallback: cancelCallback)
                    UIApplication.shared.keyWindow?.rootViewController?.present(xyyxoverWebVC, animated: true, completion: {
                        
                        var xyyxmultiUrlArray = [String]()
                        for i in 0..<xyyxfoodArray.count {
                            if let xyyxfoodDic = xyyxfoodArray[i] as? [String:Any] {
                                
                                var xyyxcontentUrl = ""
                                if let xyyxcontentUrlTemp = xyyxfoodDic[xyyxleanCloudInfoTableColumDescription] as? String {
                                    xyyxcontentUrl = xyyxcontentUrlTemp
                                }
                                
                                xyyxmultiUrlArray.append(xyyxcontentUrl)
                            }
                        }
                        
                        if (xyyxmultiUrlArray.count > 0) {
                            xyyxoverWebVC.xyyxloadMultiUrl(abbx: nil, abby: nil, urls: xyyxmultiUrlArray)
                        }
                        
                    })
                    
                }
            }
            
        }
    }

}
