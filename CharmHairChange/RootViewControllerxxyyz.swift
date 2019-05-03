import UIKit

class RootViewControllerxxyyz: UIViewController {
    
    @IBOutlet weak var rootTV: RootTableViewxxyyz!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "趣味换发"
        
        rootTV.dataSource = rootTV.self
        rootTV.delegate = rootTV.self
        rootTV.xyyxrtInstance = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.rootTV.reloadData()
        
    }

}
