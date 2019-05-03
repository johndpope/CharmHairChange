import UIKit

class ViewControllerTableViewCellxxyyz: UITableViewCell {

    @IBOutlet weak var cellMainView: UIView!
    @IBOutlet weak var cateImageView: UIImageView!
    @IBOutlet weak var cateTitleNameLabel: UILabel!
    @IBOutlet weak var cateSubTitleNameLabel: UILabel!
    @IBOutlet weak var cateSelectBtn: UIButton!
    @IBOutlet weak var cateAttentionBtn: UIButton!
    @IBOutlet weak var cateDetailBtn: UIButton!
    
    let xyyxmainColor = xyyxappMainColor
    let xyyxsubColor = UIColor.white
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellMainView.layer.cornerRadius = 2
        cellMainView.clipsToBounds = true
        cateImageView.layer.cornerRadius = 2
        cateImageView.clipsToBounds = true
        cateTitleNameLabel.text = ""
        cateSubTitleNameLabel.text = ""
        cateSelectBtn.addTargetClosure { (sender) in
            
        }
        cateAttentionBtn.layer.cornerRadius = cateAttentionBtn.frame.height/2
        cateAttentionBtn.clipsToBounds = true
        cateAttentionBtn.backgroundColor = xyyxsubColor
        cateAttentionBtn.layer.borderColor = xyyxmainColor.cgColor
        cateAttentionBtn.layer.borderWidth = 1
        cateAttentionBtn.setTitle("+ 关注", for: UIControl.State.normal)
        cateAttentionBtn.setTitleColor(xyyxmainColor, for: UIControl.State.normal)
        cateAttentionBtn.addTargetClosure { (sender) in
            
        }
        cateDetailBtn.layer.cornerRadius = cateDetailBtn.frame.height/2
        cateDetailBtn.clipsToBounds = true
        cateDetailBtn.backgroundColor = xyyxsubColor
        cateDetailBtn.layer.borderColor = xyyxmainColor.cgColor
        cateDetailBtn.layer.borderWidth = 1
        cateDetailBtn.setTitle(" 详细 ", for: UIControl.State.normal)
        cateDetailBtn.setTitleColor(xyyxmainColor, for: UIControl.State.normal)
        cateDetailBtn.addTargetClosure { (sender) in
            
        }
        
    }

}
