//
//  MySpendsTableViewCell.swift
//  wallet
//
//  Created by Surya on 29/05/21.
//

import UIKit

class MySpendsTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlet Declaration
    @IBOutlet weak var spendTitle: UILabel!
    @IBOutlet weak var spendAmount: UILabel!
    @IBOutlet weak var spendDateAndTime: UILabel!
    @IBOutlet weak var spendIcon: UIImageView!
    @IBOutlet weak var spendIconHolderView: UIView!
    @IBOutlet weak var viewHolderView: UIView!
    
    //MARK: - View Lifecycle
    static let MySpendsTableViewCell_ID = "MySpendsTableViewCell"
    var mySpendsData:MySpend?

    //MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        spendIconHolderView.layer.cornerRadius = 20
        spendIconHolderView.layer.masksToBounds = false
        
        spendIconHolderView.layer.shadowColor = UIColor.label.cgColor
        spendIconHolderView.layer.shadowRadius = 4
        spendIconHolderView.layer.shadowOpacity = 0.2
        spendIconHolderView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        
    }

    //MARK: - Cuatom Methods
    func mySpendCellSetup(){
        guard let mySpend = mySpendsData else { return }
        spendTitle.text = mySpend.title
        spendAmount.text = "₹ \(mySpend.amount)"
        spendDateAndTime.text = mySpend.time
        spendIcon.image = UIImage(named: mySpend.icon)
    }
    
}

extension UIView {

func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 0.0, height: 110.0))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
}

func topRounded() {
    self.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
}

func bottomRounded() {
    self.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10.0)
}

func topBottomRounded() {
    self.roundCorners(corners: [.topLeft, .topRight,.bottomLeft, .bottomRight], radius: 10.0)
}

func defaultStateForBorders() {
    self.roundCorners(corners: [], radius: 0)
}

}
