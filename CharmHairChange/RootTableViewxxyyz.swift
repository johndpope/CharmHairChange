import UIKit

class RootTableViewxxyyz: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var xyyxrtInstance:RootViewControllerxxyyz!
    var xyyxrootViewDataArray = [String]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return xyyxrootViewDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let xyyxcell = tableView.dequeueReusableCell(withIdentifier: "rootTVC", for: indexPath) as! RootTableViewCellxxyyz
        
        xyyxcell.nameLabel.text = xyyxrootViewDataArray[indexPath.row]
        
        return xyyxcell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let xyyxspVC = self.xyyxrtInstance.navigationController?.splitViewController as? SplitViewControllerxxyyz {
            xyyxspVC.xyyxdetailVC?.xyyxselectCateName = self.xyyxrootViewDataArray[indexPath.row]
            xyyxspVC.xyyxdetailVC?.xyyxupdateCateSelect(abbx: nil, abby: nil)
            if let detailNavi = xyyxspVC.xyyxdetailNavi {
                xyyxspVC.showDetailViewController(detailNavi, sender: nil)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
