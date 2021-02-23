import SwiftDate
import UIKit

class ViewController: UIViewController {

    var year = DateInRegion().year
    var isTransposed = true

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

    @IBAction func transposeClick() {
        isTransposed.toggle()
        regenerateCalendar()
    }

    func regenerateCalendar() {
        let calendar = generateCalendar(for: year, transposed: isTransposed)
        calendar.layoutIfNeeded()
        let size = calendar.bounds.size
        UIGraphicsBeginImageContext(size)
        UIColor.white.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        calendar.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = image
        title = "\(year)"
    }
}

class CalendarMetadataProvider: NSObject, UIActivityItemSource {
    let image: UIImage
    let year: Int

    init(year: Int, image: UIImage) {
        self.year = year
        self.image = image
    }

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        ""
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        nil
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let imageProvider = NSItemProvider(object: image)
        let metadata = LPLinkMetadata()
        metadata.imageProvider = imageProvider
        metadata.title = "\(year) Compact Calendar"
        return metadata
    }
}