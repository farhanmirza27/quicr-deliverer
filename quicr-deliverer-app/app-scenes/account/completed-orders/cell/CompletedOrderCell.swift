
import UIKit

class CompletedOrderCell : OrderRequestCell {
    func configCell() {
        acceptBtn.setTitle("Order Completed.", for: .normal)
        acceptBtn.isEnabled = false
        acceptBtn.backgroundColor = .lightGray
        deliveryTimeLabel.text = "Delivered"
    }
}
