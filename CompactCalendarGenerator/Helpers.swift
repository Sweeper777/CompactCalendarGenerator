import UIKit
import PaddingLabel
import SwiftDate
import GridLayout

func generateLabel(text: String, backgroundColor: UIColor) -> UILabel {
    let label = PaddingLabel(frame: .zero)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    label.backgroundColor = backgroundColor
    label.textColor = .black
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 20)

    label.topInset = 3
    label.leftInset = 3
    label.rightInset = 3
    label.bottomInset = 3
    return label
}

