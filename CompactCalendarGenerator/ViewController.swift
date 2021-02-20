import SwiftDate
import UIKit

class ViewController: UIViewController {

    var year = DateInRegion().year

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var shareButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        regenerateCalendar()
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

    @IBAction func shareClick() {
        guard let imageData = imageView.image?.pngData() else {
            return
        }
        let shareSheet = UIActivityViewController(activityItems: ["\(year) Compact Calendar", imageData], applicationActivities: nil)
        shareSheet.popoverPresentationController?.barButtonItem = shareButton
        present(shareSheet, animated: true)
    }

    func regenerateCalendar() {
        let calendar = generateCalendar(for: year)
        calendar.layoutIfNeeded()
        let size = calendar.bounds.size
        UIGraphicsBeginImageContext(size)
        UIColor.white.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        ("\(year)" as NSString).draw(at: .zero, withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40)
        ])
        calendar.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = image
        title = "\(year)"
    }
}

