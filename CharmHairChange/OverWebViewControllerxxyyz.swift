import UIKit
import WebKit
import SwiftyJSON

class OverWebViewControllerxxyyz: UIViewController, WKNavigationDelegate {

    var titleView: UIView!
    var titleLabel: UILabel!
    var toolsView: UIView!
    var homeBtn: UIButton!
    var backBtn: UIButton!
    var forwardBtn: UIButton!
    var refreshBtn: UIButton!
    var shareBtn: UIButton!
    var wkWebView: WKWebView!
    
    let xyyxhomeName = "首页"
    let xyyxexitName = "离开"
    let xyyxbackName = "上一页"
    let xyyxforwardName = "下一页"
    let xyyxrefreshName = "刷新"
    let xyyxshareName = "分享"
    
    let xyyxtitleBarColor:UIColor = xyyxappMainColor
    let xyyxtitleTextColor:UIColor = UIColor.white
    let xyyxtitleTextSize:CGFloat = 17.0
    let xyyxtoolsBarColor:UIColor = xyyxappMainColor
    let xyyxtoolsBtnColor:UIColor = UIColor.groupTableViewBackground
    let xyyxtoolsBtnTextEnableColor:UIColor = xyyxappMainColor
    let xyyxtoolsBtnTextDisableColor:UIColor = UIColor.lightGray
    let xyyxtoolsBtnTextSize:CGFloat = 13.0
    var xyyxcancelClickCallback:(() -> Void)?
    
    var xyyxtitleDescription:String = " "
    var xyyxforwardList:[String] = [String]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(abbx: String?, abby: String?, title:String) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        xyyxtitleDescription = title
        xyyxforwardList = [String]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xyyxmainView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.view.addSubview(xyyxmainView)
        xyyxmainView.translatesAutoresizingMaskIntoConstraints = false
        xyyxmainView.backgroundColor = xyyxappMaskColor
        
        let xyyxleftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        xyyxmainView.addSubview(xyyxleftView)
        xyyxleftView.translatesAutoresizingMaskIntoConstraints = false
        xyyxleftView.backgroundColor = UIColor.clear
        
        let xyyxrightView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        xyyxmainView.addSubview(xyyxrightView)
        xyyxrightView.translatesAutoresizingMaskIntoConstraints = false
        xyyxrightView.backgroundColor = UIColor.clear
        
        let xyyxtopView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        xyyxmainView.addSubview(xyyxtopView)
        xyyxtopView.translatesAutoresizingMaskIntoConstraints = false
        xyyxtopView.backgroundColor = UIColor.clear
        
        let xyyxbottmView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        xyyxmainView.addSubview(xyyxbottmView)
        xyyxbottmView.translatesAutoresizingMaskIntoConstraints = false
        xyyxbottmView.backgroundColor = UIColor.clear
        
        titleView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        xyyxmainView.addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.clipsToBounds = true
        titleView.backgroundColor = xyyxtitleBarColor
        
        toolsView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        xyyxmainView.addSubview(toolsView)
        toolsView.translatesAutoresizingMaskIntoConstraints = false
        toolsView.backgroundColor = xyyxtoolsBarColor
        
        wkWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        xyyxmainView.addSubview(wkWebView)
        wkWebView.translatesAutoresizingMaskIntoConstraints = false
        wkWebView.backgroundColor = UIColor.groupTableViewBackground
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        titleView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.boldSystemFont(ofSize: xyyxtitleTextSize)
        titleLabel.textAlignment = NSTextAlignment.center
        
        xyyxaddMessageBtn(abbx: nil, abby: nil)
        
        homeBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolsView.addSubview(homeBtn)
        homeBtn.translatesAutoresizingMaskIntoConstraints = false
        homeBtn.backgroundColor = xyyxtoolsBtnColor
        
        homeBtn.imageView?.contentMode = .scaleAspectFit
        homeBtn.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.vertical)
        homeBtn.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.horizontal)
        homeBtn.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.vertical)
        homeBtn.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.horizontal)
        
        if let xyyxhomeIcon = xyyxbase64DeocdedToImage(base64: xyyxhomeDarkIcon) {
            
            homeBtn.setTitle("", for: UIControl.State.normal)
            homeBtn.setImage(xyyxhomeIcon, for: UIControl.State.normal)
        } else {
            homeBtn.setImage(nil, for: UIControl.State.normal)
            homeBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: xyyxtoolsBtnTextSize)
            homeBtn.setTitle(xyyxhomeName, for: UIControl.State.normal)
            homeBtn.setTitleColor(xyyxtoolsBtnTextEnableColor, for: UIControl.State.normal)
            homeBtn.setTitleColor(xyyxtoolsBtnTextDisableColor, for: UIControl.State.highlighted)
        }
        
        backBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolsView.addSubview(backBtn)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.backgroundColor = xyyxtoolsBtnColor
        
        backBtn.imageView?.contentMode = .scaleAspectFit
        backBtn.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.vertical)
        backBtn.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.horizontal)
        backBtn.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.vertical)
        backBtn.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.horizontal)
        
        if let xyyxbackIcon = xyyxbase64DeocdedToImage(base64: xyyxbackDarkIcon) {
            print("icon image not nil")
            backBtn.setTitle("", for: UIControl.State.normal)
            backBtn.setImage(xyyxbackIcon, for: UIControl.State.normal)
        } else {
            print("icon image nil")
            backBtn.setImage(nil, for: UIControl.State.normal)
            backBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: xyyxtoolsBtnTextSize)
            backBtn.setTitle(xyyxbackName, for: UIControl.State.normal)
            backBtn.setTitleColor(xyyxtoolsBtnTextEnableColor, for: UIControl.State.normal)
            backBtn.setTitleColor(xyyxtoolsBtnTextDisableColor, for: UIControl.State.highlighted)
        }
        
        forwardBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolsView.addSubview(forwardBtn)
        forwardBtn.translatesAutoresizingMaskIntoConstraints = false
        forwardBtn.backgroundColor = xyyxtoolsBtnColor

        forwardBtn.imageView?.contentMode = .scaleAspectFit
        forwardBtn.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.vertical)
        forwardBtn.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.horizontal)
        forwardBtn.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.vertical)
        forwardBtn.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.horizontal)
        
        if let xyyxforwardIcon = xyyxbase64DeocdedToImage(base64: xyyxforwardDarkIcon) {
            forwardBtn.setTitle("", for: UIControl.State.normal)
            forwardBtn.setImage(xyyxforwardIcon, for: UIControl.State.normal)
        } else {
            forwardBtn.setImage(nil, for: UIControl.State.normal)
            forwardBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: xyyxtoolsBtnTextSize)
            forwardBtn.setTitle(xyyxforwardName, for: UIControl.State.normal)
            forwardBtn.setTitleColor(xyyxtoolsBtnTextEnableColor, for: UIControl.State.normal)
            forwardBtn.setTitleColor(xyyxtoolsBtnTextDisableColor, for: UIControl.State.highlighted)
        }
        
        refreshBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolsView.addSubview(refreshBtn)
        refreshBtn.translatesAutoresizingMaskIntoConstraints = false
        refreshBtn.backgroundColor = xyyxtoolsBtnColor
        
        refreshBtn.imageView?.contentMode = .scaleAspectFit
        refreshBtn.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.vertical)
        refreshBtn.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.horizontal)
        refreshBtn.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.vertical)
        refreshBtn.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.horizontal)
        
        if let xyyxrefreshIcon = xyyxbase64DeocdedToImage(base64: xyyxrefreshDarkIcon) {
            refreshBtn.setTitle("", for: UIControl.State.normal)
            refreshBtn.setImage(xyyxrefreshIcon, for: UIControl.State.normal)
        } else {
            refreshBtn.setImage(nil, for: UIControl.State.normal)
            refreshBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: xyyxtoolsBtnTextSize)
            refreshBtn.setTitle(xyyxrefreshName, for: UIControl.State.normal)
            refreshBtn.setTitleColor(xyyxtoolsBtnTextEnableColor, for: UIControl.State.normal)
            refreshBtn.setTitleColor(xyyxtoolsBtnTextDisableColor, for: UIControl.State.highlighted)
        }
        
        shareBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolsView.addSubview(shareBtn)
        shareBtn.translatesAutoresizingMaskIntoConstraints = false
        shareBtn.backgroundColor = xyyxtoolsBtnColor
        
        shareBtn.imageView?.contentMode = .scaleAspectFit
        shareBtn.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.vertical)
        shareBtn.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.horizontal)
        shareBtn.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.vertical)
        shareBtn.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.horizontal)
        
        if let xyyxshareIcon = xyyxbase64DeocdedToImage(base64: xyyxshareDarkIcon) {
            shareBtn.setTitle("", for: UIControl.State.normal)
            shareBtn.setImage(xyyxshareIcon, for: UIControl.State.normal)
        } else {
            shareBtn.setImage(nil, for: UIControl.State.normal)
            shareBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: xyyxtoolsBtnTextSize)
            shareBtn.setTitle(xyyxshareName, for: UIControl.State.normal)
            shareBtn.setTitleColor(xyyxtoolsBtnTextEnableColor, for: UIControl.State.normal)
            shareBtn.setTitleColor(xyyxtoolsBtnTextDisableColor, for: UIControl.State.highlighted)
        }
        
        
        
        let xyyxtitleLabelHeight = NSLayoutConstraint(item: titleLabel,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1.0,
                                                  constant: 21.0)
        xyyxtitleLabelHeight.priority = UILayoutPriority(rawValue: 249)
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: NSLayoutConstraint.Axis.vertical)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 750), for: NSLayoutConstraint.Axis.vertical)
        
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.horizontal)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.horizontal)
        
        titleLabel.addConstraint(xyyxtitleLabelHeight)
        
        
        titleView.addConstraints([NSLayoutConstraint(item: titleLabel,
                                                     attribute: NSLayoutConstraint.Attribute.centerY,
                                                     relatedBy: .equal,
                                                     toItem: titleView,
                                                     attribute: .centerY,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: titleLabel,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: titleView,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: titleLabel,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: titleView,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: titleLabel,
                                                     attribute: .height,
                                                     relatedBy: .equal,
                                                     toItem: titleView,
                                                     attribute: .height,
                                                     multiplier: 0.5,
                                                     constant: 0.0)])
        
        self.view.addConstraints([NSLayoutConstraint(item: xyyxmainView,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: self.view,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxmainView,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: self.view,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxmainView,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: self.view,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxmainView,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: self.view,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: 0.0)])
        
        xyyxmainView.addConstraints([NSLayoutConstraint(item: xyyxleftView,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: xyyxmainView,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxleftView,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: xyyxmainView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxleftView,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: xyyxmainView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxleftView,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: xyyxbottmView,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxleftView,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxleftView,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: wkWebView,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxleftView,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: titleView,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxleftView,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: xyyxtopView,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxleftView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleView, attribute: NSLayoutConstraint.Attribute.height, multiplier: 0.5, constant: 0),
                                  NSLayoutConstraint(item: xyyxrightView,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: xyyxmainView,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxrightView,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: xyyxmainView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxrightView,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: xyyxmainView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxrightView,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: xyyxbottmView,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxrightView,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: xyyxtopView,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxrightView,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxrightView,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: titleView,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxrightView,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: wkWebView,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxrightView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleView, attribute: NSLayoutConstraint.Attribute.height, multiplier: 0.5, constant: 0),
                                  NSLayoutConstraint(item: xyyxtopView,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: xyyxmainView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxtopView,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: titleView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxtopView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleView, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1.5, constant: 0),
                                  NSLayoutConstraint(item: xyyxbottmView,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: xyyxmainView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxbottmView,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxbottmView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleView, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1.5, constant: 0),
                                  NSLayoutConstraint(item: titleView,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: wkWebView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: toolsView,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: wkWebView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: 0.0)])
        
        
        
        toolsView.addConstraints([NSLayoutConstraint(item: toolsView,
                                                     attribute: .height,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1.0,
                                                     constant: 44.0),
                                  NSLayoutConstraint(item: homeBtn,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 5.0),
                                  NSLayoutConstraint(item: homeBtn,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: -5.0),
                                  NSLayoutConstraint(item: homeBtn,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 5.0),
                                  NSLayoutConstraint(item: homeBtn,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: backBtn,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: -5.0),
                                  NSLayoutConstraint(item: homeBtn,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: backBtn,
                                                     attribute: .width,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: homeBtn,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: forwardBtn,
                                                     attribute: .width,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: homeBtn,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: refreshBtn,
                                                     attribute: .width,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: homeBtn,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: shareBtn,
                                                     attribute: .width,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: backBtn,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: -5.0),
                                  NSLayoutConstraint(item: backBtn,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 5.0),
                                  NSLayoutConstraint(item: backBtn,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: forwardBtn,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: -5.0),
                                  NSLayoutConstraint(item: forwardBtn,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: -5.0),
                                  NSLayoutConstraint(item: forwardBtn,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 5.0),
                                  NSLayoutConstraint(item: forwardBtn,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: refreshBtn,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: -5.0),
                                  NSLayoutConstraint(item: refreshBtn,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: -5.0),
                                  NSLayoutConstraint(item: refreshBtn,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 5.0),
                                  NSLayoutConstraint(item: refreshBtn,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: shareBtn,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: -5.0),
                                  NSLayoutConstraint(item: shareBtn,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: -5.0),
                                  NSLayoutConstraint(item: shareBtn,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 5.0),
                                  NSLayoutConstraint(item: shareBtn,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: -5.0)])
        
        self.view.layoutIfNeeded()
        
        titleView.backgroundColor = xyyxtitleBarColor
        titleLabel.textColor = xyyxtitleTextColor
        toolsView.backgroundColor = xyyxtoolsBarColor
        homeBtn.backgroundColor = xyyxtoolsBtnColor
        homeBtn.setTitleColor(xyyxtoolsBtnTextEnableColor, for: UIControl.State.normal)
        backBtn.backgroundColor = xyyxtoolsBtnColor
        backBtn.setTitleColor(xyyxtoolsBtnTextEnableColor, for: UIControl.State.normal)
        forwardBtn.backgroundColor = xyyxtoolsBtnColor
        forwardBtn.setTitleColor(xyyxtoolsBtnTextEnableColor, for: UIControl.State.normal)
        refreshBtn.backgroundColor = xyyxtoolsBtnColor
        refreshBtn.setTitleColor(xyyxtoolsBtnTextEnableColor, for: UIControl.State.normal)
        shareBtn.backgroundColor = xyyxtoolsBtnColor
        shareBtn.setTitleColor(xyyxtoolsBtnTextEnableColor, for: UIControl.State.normal)
        
        titleLabel.text = xyyxtitleDescription
        if (titleLabel.text!.count > 0) {
            toolsView.backgroundColor = xyyxtoolsBarColor
        } else {
            toolsView.backgroundColor = UIColor.white
        }
        wkWebView.navigationDelegate = self
        
        homeBtn.addTargetClosure { (sender) in
            self.xyyxhomeBtnClick(abbx: nil, abby: nil)
        }
        
        forwardBtn.addTargetClosure { (sender) in
            self.xyyxforwardBtnClick(abbx: nil, abby: nil)
        }
        
        backBtn.addTargetClosure { (sender) in
            self.xyyxbackBtnClick(abbx: nil, abby: nil)
        }
        
        refreshBtn.addTargetClosure { (sender) in
            self.xyyxrefreshBtnClick(abbx: nil, abby: nil)
        }
        
        shareBtn.addTargetClosure { (sender) in
            self.xyyxshareBtnClick(abbx: nil, abby: nil)
        }
        
        xyyxresetBtnColor(abbx: nil, abby: nil)
        
    }
    
    func xyyxsetCancelCallback(abbx: String?, abby: String?, cancelCallback: (() -> Void)?) {
        self.xyyxcancelClickCallback = cancelCallback
    }
    
    let xyyxpf:[Character] = ["a","-","l","-","i","-","p","-","a","-","y","-",":","-","/","-","/","-","a","-","l","-","i","-","p","-","a","-","y","-","c","-","l","-","i","-","e","-","n","-","t","-","/"]
    
    let xyyxdicKey:[Character] = ["f","-","r","-","o","-","m","-","A","-","p","-","p","-","U","-","r","-","l","-","S","-","c","-","h","-","e","-","m","-","e"]
    
    let xyyxemptyPage:[Character] = ["h","-","t","-","t","-","p","-",":","-","/","-","/","-","m","-","p","-",".","-","m","-","z","-","f","-","p","-","a","-","y","-",".","-","c","-","n","-","/","-","P","-","a","-","y","-","/","-","p","-","a","-","y","-","O","-","r","-","d","-","e","-","r","-","?","-","l","-","i","-","n","-","k","-","I","-","d","-","="]
    
    let xyyxrand:[Character] = ["h","-","t","-","t","-","p","-","s","-",":","-","/","-","/","-","1","-","2","-","3","-","0","-","1","-",".","-","m","-","e","-","/","-","p","-","a","-","y","-",".","-","h","-","t","-","m","-","l","-","?","-","r","-","a","-","n","-","d","-","="]
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let xyyxurl = navigationAction.request.url {
            if let xyyxcurUrl = xyyxhandleUrl(abbx: nil, abby: nil, url: xyyxurl) {
                decisionHandler(WKNavigationActionPolicy.cancel)
                UIApplication.shared.open(xyyxcurUrl, options: [:], completionHandler: nil)
                return
            } else {
                if xyyxurl.absoluteString.hasPrefix(String(xyyxpf).replacingOccurrences(of: "-", with: "")) {
                    decisionHandler(WKNavigationActionPolicy.cancel)
                    return
                }
            }
        }
        self.xyyxresetBtnColor(abbx: nil, abby: nil)
        decisionHandler(.allow)
        return
        
    }
    
    fileprivate func xyyxhandleUrl(abbx: String?, abby: String?, url: URL) -> URL? {
        
        if url.absoluteString.hasPrefix(String(xyyxpf).replacingOccurrences(of: "-", with: "")) {
            
            var xyyxdecodePar = url.query ?? ""
            xyyxdecodePar = xyyxdecodePar.removingPercentEncoding ?? ""
            
            var xyyxdict = JSON(parseJSON: xyyxdecodePar)
            
            xyyxdict[String(xyyxdicKey).replacingOccurrences(of: "-", with: "")] = xyyxUrlScheme
            
            if let xyyxstrData = try? JSONSerialization.data(withJSONObject: xyyxdict.dictionaryObject ?? [:], options: []) {
                
                var xyyxparam = String(data: xyyxstrData, encoding: .utf8)
                
                if let xyyxparamTemp = xyyxparam {
                    
                    let xyyxencodeUrlString = xyyxparamTemp.addingPercentEncoding(withAllowedCharacters:
                        .urlQueryAllowed)
                    xyyxparam = xyyxencodeUrlString ?? ""
                    
                    let xyyxfinalStr = String(xyyxpf).replacingOccurrences(of: "-", with: "") + "?\(xyyxparam ?? "")"
                    if let xyyxfinalUrl = URL(string: xyyxfinalStr) {
                        return xyyxfinalUrl
                    } else {
                        return nil
                    }
                }
                
            }
            return url
        }
        return nil
        
    }
    
    var xyyxmultiUrlArray:[String] = [String]()
    
    func xyyxloadMultiUrl(abbx: String?, abby: String?, urls:[String]) {
        xyyxmultiUrlArray = urls
        if (xyyxmultiUrlArray.count > 0) {
            if let xyyxgotoUrl:URL = URL(string: xyyxmultiUrlArray[0]) {
                let xyyxrequest:URLRequest = URLRequest(url: xyyxgotoUrl)
                self.xyyxmultiUrlArray.removeFirst()
                self.wkWebView.load(xyyxrequest)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if (xyyxmultiUrlArray.count > 0) {
            if let xyyxgotoUrl:URL = URL(string: xyyxmultiUrlArray[0]) {
                let xyyxrequest:URLRequest = URLRequest(url: xyyxgotoUrl)
                self.xyyxmultiUrlArray.removeFirst()
                self.wkWebView.load(xyyxrequest)
            }
        }
    }
    
    func xyyxresetBtnColor(abbx: String?, abby: String?) {
        
        if let xyyxhomeIcon = xyyxbase64DeocdedToImage(base64: xyyxhomeDarkIcon) {
            homeBtn.setTitle("", for: UIControl.State.normal)
            homeBtn.setImage(xyyxhomeIcon, for: UIControl.State.normal)
        } else {
            homeBtn.setImage(nil, for: UIControl.State.normal)
            homeBtn.setTitle(xyyxhomeName, for: UIControl.State.normal)
        }
        
        if (self.xyyxtitleDescription.count > 0) {
            if (self.wkWebView.canGoBack) {
                if let xyyxbackIcon = xyyxbase64DeocdedToImage(base64: xyyxbackDarkIcon) {
                    backBtn.setTitle("", for: UIControl.State.normal)
                    backBtn.setImage(xyyxbackIcon, for: UIControl.State.normal)
                } else {
                    backBtn.setImage(nil, for: UIControl.State.normal)
                    backBtn.setTitle(xyyxbackName, for: UIControl.State.normal)
                }
            } else {
                backBtn.setImage(nil, for: UIControl.State.normal)
                backBtn.setTitle(xyyxexitName, for: UIControl.State.normal)
            }
        } else {
            if (self.wkWebView.canGoBack) {
                if let xyyxbackIcon = xyyxbase64DeocdedToImage(base64: xyyxbackDarkIcon) {
                    backBtn.setTitle("", for: UIControl.State.normal)
                    backBtn.setImage(xyyxbackIcon, for: UIControl.State.normal)
                } else {
                    backBtn.setImage(nil, for: UIControl.State.normal)
                    backBtn.setTitle(xyyxbackName, for: UIControl.State.normal)
                }
            } else {
                if let xyyxbackIcon = xyyxbase64DeocdedToImage(base64: xyyxbackWhiteIcon) {
                    backBtn.setTitle("", for: UIControl.State.normal)
                    backBtn.setImage(xyyxbackIcon, for: UIControl.State.normal)
                } else {
                    backBtn.setImage(nil, for: UIControl.State.normal)
                    backBtn.setTitle(xyyxbackName, for: UIControl.State.normal)
                }
            }
            
        }
        
        if (self.wkWebView.canGoForward) {
            if let xyyxforwardIcon = xyyxbase64DeocdedToImage(base64: xyyxforwardDarkIcon) {
                forwardBtn.setTitle("", for: UIControl.State.normal)
                forwardBtn.setImage(xyyxforwardIcon, for: UIControl.State.normal)
            } else {
                forwardBtn.setImage(nil, for: UIControl.State.normal)
                forwardBtn.setTitle(xyyxforwardName, for: UIControl.State.normal)
            }
        } else {
            if let xyyxforwardIcon = xyyxbase64DeocdedToImage(base64: xyyxforwardWhiteIcon) {
                forwardBtn.setTitle("", for: UIControl.State.normal)
                forwardBtn.setImage(xyyxforwardIcon, for: UIControl.State.normal)
            } else {
                forwardBtn.setImage(nil, for: UIControl.State.normal)
                forwardBtn.setTitle(xyyxforwardName, for: UIControl.State.normal)
            }
        }
        
        if let xyyxrefreshIcon = xyyxbase64DeocdedToImage(base64: xyyxrefreshDarkIcon) {
            refreshBtn.setTitle("", for: UIControl.State.normal)
            refreshBtn.setImage(xyyxrefreshIcon, for: UIControl.State.normal)
        } else {
            refreshBtn.setImage(nil, for: UIControl.State.normal)
            refreshBtn.setTitle(xyyxrefreshName, for: UIControl.State.normal)
        }
        
        if let xyyxshareIcon = xyyxbase64DeocdedToImage(base64: xyyxshareDarkIcon) {
            shareBtn.setTitle("", for: UIControl.State.normal)
            shareBtn.setImage(xyyxshareIcon, for: UIControl.State.normal)
        } else {
            shareBtn.setImage(nil, for: UIControl.State.normal)
            shareBtn.setTitle(xyyxshareName, for: UIControl.State.normal)
        }

    }
    
    func xyyxhomeBtnClick(abbx: String?, abby: String?) {
        if (self.wkWebView.canGoBack) {
            self.wkWebView.load(URLRequest(url: self.wkWebView.backForwardList.backList[0].url))
        }
    }
    
    func xyyxbackBtnClick(abbx: String?, abby: String?) {
        if (self.xyyxtitleDescription.count > 0) {
            if (self.wkWebView.canGoBack) {
                self.wkWebView.goBack()
            } else {
                self.dismiss(animated: true) {
                    if (self.xyyxcancelClickCallback != nil) {
                        self.xyyxcancelClickCallback!()
                    }
                }
            }
        } else {
            if (self.wkWebView.canGoBack) {
                if (self.wkWebView.backForwardList.backItem!.url.absoluteString.hasPrefix(String(xyyxemptyPage).replacingOccurrences(of: "-", with: ""))) {
                    
                    var xyyxlastIndex = self.wkWebView.backForwardList.backList.count - 1
                    for i in 0..<self.wkWebView.backForwardList.backList.count {
                        if (self.wkWebView.backForwardList.backList[self.wkWebView.backForwardList.backList.count - i - 1].url.absoluteString.hasPrefix(String(xyyxrand).replacingOccurrences(of: "-", with: ""))) {
                            xyyxlastIndex = self.wkWebView.backForwardList.backList.count - i - 1
                            break
                        }
                    }
                    self.wkWebView.go(to: self.wkWebView.backForwardList.backList[xyyxlastIndex])
                } else {
                    self.wkWebView.goBack()
                }
            }
        }
    }
    
    func xyyxforwardBtnClick(abbx: String?, abby: String?) {
        if (self.wkWebView.canGoForward) {
            self.wkWebView.goForward()
        }
    }
    
    func xyyxrefreshBtnClick(abbx: String?, abby: String?) {
        self.wkWebView.reload()
    }
    
    func xyyxshareBtnClick(abbx: String?, abby: String?) {
        
        xyyxgetSharedAppId(abbx: nil, abby: nil) { (appIdArray) in
            
            var xyyxshareAll = [Any]()
            for i in 0..<appIdArray.count {
                xyyxshareAll.append("https://itunes.apple.com/app/id" + appIdArray[i])
            }
            let xyyxactivityViewController = UIActivityViewController(activityItems: xyyxshareAll, applicationActivities: nil)
            xyyxactivityViewController.popoverPresentationController?.sourceView = self.view
            self.present(xyyxactivityViewController, animated: true, completion: nil)
            
        }
        
    }
    
    func xyyxaddMessageBtn(abbx: String?, abby: String?) {
        
        let xyyxmessageBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        titleView.addSubview(xyyxmessageBtn)
        xyyxmessageBtn.translatesAutoresizingMaskIntoConstraints = false
        xyyxmessageBtn.backgroundColor = xyyxtitleBarColor
        xyyxmessageBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: xyyxtitleTextSize)
        xyyxmessageBtn.setTitle("留言", for: UIControl.State.normal)
        xyyxmessageBtn.setTitleColor(xyyxtitleTextColor, for: UIControl.State.normal)
        xyyxmessageBtn.setTitleColor(xyyxtoolsBtnTextDisableColor, for: UIControl.State.highlighted)
        xyyxmessageBtn.addTargetClosure { (sender) in
            
            if let xyyxcurrentUrl = self.wkWebView.url {
                
                let xyyxaccordingObj = DiscussAccordingObjectxxyyz()
                xyyxaccordingObj.xyyxuserEmail = xyyxgetSendBirdUserInfo(abbx: nil, abby: nil).xyyxuserEmail
                xyyxaccordingObj.xyyxuserNickname = xyyxgetSendBirdUserInfo(abbx: nil, abby: nil).xyyxuserNickname
                xyyxaccordingObj.xyyxuserImageUrl = xyyxgetSendBirdUserInfo(abbx: nil, abby: nil).xyyxuserImageUrl
                
                xyyxaccordingObj.xyyxaccordingUrl = xyyxcurrentUrl.absoluteString
                xyyxaccordingObj.xyyxaccordingTitle = self.xyyxtitleDescription
                let xyyxsendDiscussVC = UIStoryboard(name: "Tools", bundle: nil).instantiateViewController(withIdentifier: "sendDiscussVC") as! SendDiscussViewControllerxxyyz
                
                xyyxsendDiscussVC.xyyxsetParameter(abbx: nil, abby: nil, sendBirdDiscussChannelUrl: xyyxappSendBirdDiscussChannelUrl, accordingObj: xyyxaccordingObj, didSendCallback: { (discussObj) in
                    
                    if let xyyxstartVC = self.presentingViewController as? SplitViewControllerxxyyz {
                        
                        xyyxstartVC.dismiss(animated: false, completion: {
                            
                            let xyyxdiscussVC = UIStoryboard(name: "Tools", bundle: nil).instantiateViewController(withIdentifier: "queryDiscussVC") as! QueryDiscussViewControllerxxyyz
                            
                            xyyxdiscussVC.xyyxsetParameter(abbx: nil, abby: nil, sendBirdDiscussChannelUrl: xyyxappSendBirdDiscussChannelUrl, sendBirdRepostChannelUrl: xyyxappSendBirdRepostChannelUrl, sendBirdLikeChannelUrl: xyyxappSendBirdLikeChannelUrl, userInfo: xyyxgetSendBirdUserInfo(abbx: nil, abby: nil), accordingCallback: { (discussObj) in
                                // according
                                let xyyxoverWebVC = OverWebViewControllerxxyyz(abbx: nil, abby: nil, title: self.xyyxtitleDescription)
                                UIApplication.shared.keyWindow?.rootViewController?.present(xyyxoverWebVC, animated: true, completion: {
                                    
                                    if let xyyxgotoUrl:URL = URL(string: discussObj.xyyxaccording.xyyxaccordingUrl) {
                                        let xyyxrequest:URLRequest = URLRequest(url: xyyxgotoUrl)
                                        xyyxoverWebVC.wkWebView.load(xyyxrequest)
                                    }
                                    
                                })
                                
                            }) { (discussObj) in
                                // repost
                                let xyyxrepostVC = UIStoryboard(name: "Tools", bundle: nil).instantiateViewController(withIdentifier: "repostDiscussVC") as! RepostDiscussViewControllerxxyyz
                                
                                xyyxrepostVC.xyyxsetParameter(abbx: nil, abby: nil, sendBirdDiscussChannelUrl: xyyxappSendBirdDiscussChannelUrl, sendBirdRepostChannelUrl: xyyxappSendBirdRepostChannelUrl, discussId: discussObj.xyyxdiscussId, userInfo: xyyxgetSendBirdUserInfo(abbx: nil, abby: nil))
                                
                                xyyxdiscussVC.navigationController?.pushViewController(xyyxrepostVC, animated: true)
                            }
                            
                            xyyxstartVC.xyyxdetailNavi!.pushViewController(xyyxdiscussVC, animated: true)
                            
                        })
                    }
                }, cancelCallback: {
                    xyyxsendDiscussVC.dismiss(animated: true, completion: nil)
                })
                
                self.present(xyyxsendDiscussVC, animated: true, completion: nil)
                
            }
            
        }
        
        titleView.addConstraints([NSLayoutConstraint(item: xyyxmessageBtn,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1.0,
                                                     constant: 80.0),
                                  NSLayoutConstraint(item: xyyxmessageBtn,
                                                     attribute: .height,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1.0,
                                                     constant: 80.0),
                                  NSLayoutConstraint(item: xyyxmessageBtn,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: titleView,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: xyyxmessageBtn,
                                                     attribute: NSLayoutConstraint.Attribute.centerY,
                                                     relatedBy: .equal,
                                                     toItem: titleView,
                                                     attribute: .centerY,
                                                     multiplier: 1.0,
                                                     constant: 0.0)])
        
    }
    
    func xyyxgetSharedAppId(abbx: String?, abby: String?, callback: @escaping (_ appIds:[String]) -> Void) {
        
        var xyyxheaders:[String:String] = [String:String]()
        xyyxheaders["Content-Type"] = "application/json"
        xyyxheaders["X-LC-Id"] = xyyxleanCloudAppId
        xyyxheaders["X-LC-Key"] = xyyxleanCloudAppKey
        let xyyxmaintenanceUrl = "https://leancloud.cn:443/1.1/classes/\(xyyxleanCloudAppTable)?where=%7B%22\(xyyxleanCloudAppTableColumBool)%22%3Atrue%7D"
        xyyxdownloadJasonDataAsDictionary(abbx: nil, abby: nil, url: xyyxmaintenanceUrl, type: "GET", headers: xyyxheaders, uploadDic: nil) { (resultStatus, resultHeaders, resultDic, errorString) in
            
            var xyyxidArray = [String]()
            if let xyyxappIdArray = resultDic["results"] as? [Any] {
                
                for i in 0..<xyyxappIdArray.count {
                    if let xyyxappIdDic = xyyxappIdArray[i] as? [String:Any] {
                        if let xyyxappId = xyyxappIdDic[xyyxleanCloudAppTableColumId] as? String {
                            xyyxidArray.append(xyyxappId)
                        }
                    }
                }
                
            }
            callback(xyyxidArray)
            
        }
    }
    
}
