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

func generateDaysGridItems(year: Int) -> [GridItem] {
    func getColor(white: Bool, dayNumber: Int) -> UIColor {
        let isLeap = Year(year).isLeap()
        if (dayNumber == 29 && isLeap) || (dayNumber == 28 && !isLeap) {
            return UIColor(named: "februaryColor")!
        }
        if dayNumber == 30 || dayNumber == 31 {
            return monthDaysCountToColor[dayNumber]!
        }
        return white ? .white : UIColor(white: 0.75, alpha: 1.0)
    }

    var white = true
    var gridItems = [GridItem]()
    for i in 0..<31 {
        gridItems.append(
                GridItem(generateLabel(
                        text: "\(i + 1)",
                        backgroundColor: getColor(white: white, dayNumber: i + 1)),
                        row: i % 7, column: i / 7,
                        horizontalAlignment: .stretch)
        )
        white.toggle()
    }
    return gridItems
}

extension GridItem {
    func shift(dx: Int = 0, dy: Int = 0) {
        position.column += dx
        position.row += dy
    }
}
// https://stackoverflow.com/a/43772545/5133585
extension RangeReplaceableCollection {
    func rotatingLeft(positions: Int) -> SubSequence {
        let index = self.index(startIndex, offsetBy: positions, limitedBy: endIndex) ?? endIndex
        return self[index...] + self[..<index]
    }
    mutating func rotateLeft(positions: Int) {
        let index = self.index(startIndex, offsetBy: positions, limitedBy: endIndex) ?? endIndex
        let slice = self[..<index]
        removeSubrange(..<index)
        insert(contentsOf: slice, at: endIndex)
    }
}

