//
//  MySpendsTableViewCell.swift
//  wallet
//
//  Created by Surya on 21/05/21.
//

import UIKit

fileprivate typealias collectionDiffableDataSource = UICollectionViewDiffableDataSource<String,FriendsList>

class SendMoneyTabelCell: UITableViewCell {

    @IBOutlet weak var addImageHolderView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Property Declaration
    static var SendMoneyTabelCell_ID = "SendMoneyTabelCell"
    private var collectionViewdataSource: collectionDiffableDataSource!
    var friendsDetails: [FriendsList]?
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        addImageHolderView.layer.cornerRadius = 25
        addImageHolderView.layer.masksToBounds = false
        
        addImageHolderView.layer.shadowColor = UIColor.label.cgColor
        addImageHolderView.layer.shadowOffset = CGSize(width: 0, height: 2)
        addImageHolderView.layer.shadowRadius = 4
        addImageHolderView.layer.shadowOpacity = 0.2
    }
    
    //MARK: Custom Methods
    func collectionViewSetup(){
        
        collectionView.delegate = self
        //Register cell
        collectionView.register(UINib(nibName: FriendsListCollectionViewCell.FriendsListCollectionViewCell_ID, bundle: nil), forCellWithReuseIdentifier: FriendsListCollectionViewCell.FriendsListCollectionViewCell_ID)
        
        //Setup data source
        self.configureCollectionViewDataSource(collectionView: collectionView)
        self.applyCollectionViewSnapshot()
    }
    
    func configureCollectionViewDataSource(collectionView: UICollectionView){
        collectionViewdataSource = collectionDiffableDataSource(collectionView: collectionView,
                                                                cellProvider:
                                                                    { (collectionView, indexpath, friendsDetails) -> UICollectionViewCell? in
            let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsListCollectionViewCell.FriendsListCollectionViewCell_ID, for: indexpath) as? FriendsListCollectionViewCell
            collectionViewCell?.friendDetails = friendsDetails
            collectionViewCell?.updateCollectionCell()
            return collectionViewCell
           
        })
    }
    
    func applyCollectionViewSnapshot(){
        var snapShot = NSDiffableDataSourceSnapshot<String,FriendsList>()
        snapShot.appendSections(["0"])
        snapShot.appendItems(friendsDetails!, toSection: "0")
        collectionViewdataSource.apply(snapShot, animatingDifferences: true)
            
    }
    
}

extension SendMoneyTabelCell: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
