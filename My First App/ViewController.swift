import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var centerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonTapped(_ sender: Any) {
        view.backgroundColor = .green
        centerLabel.text = "I like cheese!"
        centerLabel.textColor = .white
    }
    
}

