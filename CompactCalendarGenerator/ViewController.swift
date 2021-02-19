import SwiftDate
import UIKit

class ViewController: UIViewController {

    var year = DateInRegion().year

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var shareButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func plus1() {
        year += 1
        regenerateCalendar()
    }

    @IBAction func plus10() {
        year += 10
        regenerateCalendar()
    }

    @IBAction func minus1() {
        year -= 1
        regenerateCalendar()
    }

    @IBAction func minus10() {
        year -= 10
        regenerateCalendar()
    }

}

