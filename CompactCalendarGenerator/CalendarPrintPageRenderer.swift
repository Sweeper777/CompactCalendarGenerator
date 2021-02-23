import UIKit

class CalendarPrintPageRenderer: UIPrintPageRenderer {
    let image: UIImage

    init(image: UIImage) {
        self.image = image
    }

    override func drawPage(at pageIndex: Int, in printableRect: CGRect) {
        let xScale = printableRect.width / image.size.width
        let yScale = printableRect.height / image.size.height
        let scale = min(xScale, yScale)
        image.draw(in: CGRect(origin: printableRect.origin, size: CGSize(width: image.size.width * scale, height: image.size.height * scale)))
    }

    override func drawPrintFormatter(_ printFormatter: UIPrintFormatter, forPageAt pageIndex: Int) {

    }
}