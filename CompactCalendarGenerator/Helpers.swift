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

let monthDaysCountToColor = [
    28: UIColor(named: "februaryColor")!,
    29: UIColor(named: "februaryColor")!,
    30: UIColor(named: "30daysColor")!,
    31: UIColor(named: "31daysColor")!,
]

func monthsGroupedByDayOfWeekOfFirstDay(year: Int) -> [Int: [Month]] {
    let allFirstDaysOfMonth = (1...12).map { DateInRegion(year: year, month: $0, day: 1, region: Region.ISO) }
    return Dictionary(grouping: allFirstDaysOfMonth) { date in date.weekday }
            .mapValues { $0.map { Month(rawValue: $0.month - 1)! } }
}

