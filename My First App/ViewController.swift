import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var centerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        centerLabel.text = "I like cheese!"
        centerLabel.textColor = .white
    }


}

