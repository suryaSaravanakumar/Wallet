//
//  FriendsListCollectionViewCell.swift
//  wallet
//
//  Created by Surya on 21/05/21.
//

import UIKit

class FriendsListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    //MARK: Property Declaration
    static var FriendsListCollectionViewCell_ID = "FriendsListCollectionViewCell"
    var friendDetails: FriendsList?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.holderView.layer.cornerRadius = 20
        self.holderView.layer.masksToBounds = false
        self.setShadow()
    }
    
    private func setShadow() {
        self.holderView.layer.shadowColor = UIColor.label.cgColor
        self.holderView.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.holderView.layer.shadowRadius = 4
        self.holderView.layer.shadowOpacity = 0.2
    }
    
    func updateCollectionCell(){
        guard let details = friendDetails else {  return }
        nameLbl.text = details.name
        profileImageView.image = UIImage(named: details.profilePic)
    }

}
