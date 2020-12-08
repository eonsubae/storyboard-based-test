import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var centerLabel: UILabel!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonTapped(_ sender: Any) {
        count = count + 1
        centerLabel.text = String(count)
        
        if count == 10 {
            view.backgroundColor = .purple
        }
    }
    
}

