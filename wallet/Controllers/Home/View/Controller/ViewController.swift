//
//  ViewController.swift
//  wallet
//
//  Created by Surya on 16/05/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK:- Property  Declaration
    //Step - 1
    private var dataSource: UITableViewDiffableDataSource<sections,AnyHashable>!
   
    private var walletDetails:WalletModel?
    
    enum sections{
        case sendMoney
        case myBalance
    }
 
    //MARK:- IBOutlet Declaration
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
       prepareData()
       initalSetup()
    }

    override func viewDidAppear(_ animated: Bool) {
        applySnapShot()
    }
    
    //MARK:- Custom Methods
    private func initalSetup(){
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 250
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(UINib(nibName: CurrentBalanceTableViewCell.CurrentBalanceCell_ID, bundle: nil), forCellReuseIdentifier: CurrentBalanceTableViewCell.CurrentBalanceCell_ID)
        self.tableView.register(UINib(nibName: MySpendsTableViewCell.MySpendsTableViewCell_ID, bundle: nil), forCellReuseIdentifier: MySpendsTableViewCell.MySpendsTableViewCell_ID)
        
        configuareTableViewDataSource()
    }
    
    private func prepareData() {
        guard let walletData = readLocalFileAndParseData() else {return}
        walletDetails = walletData //.append(walletData)
    }
    //Step - 2
    private func configuareTableViewDataSource(){
        dataSource = UITableViewDiffableDataSource<sections,AnyHashable>(tableView: tableView, cellProvider: { (tableView, indexpath, walletDetails) -> UITableViewCell? in
            
            switch indexpath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: CurrentBalanceTableViewCell.CurrentBalanceCell_ID, for: indexpath) as? CurrentBalanceTableViewCell
                cell?.selectionStyle = .none
                if let wallet = walletDetails as? [WalletModel]{
                    cell?.currentBalance.text = "₹ \(wallet.first?.currentBalance)"
                }
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: MySpendsTableViewCell.MySpendsTableViewCell_ID, for: indexpath) as? MySpendsTableViewCell
                cell?.selectionStyle = .none
                cell?.mySpendDetails = self.walletDetails?.mySpend
                cell?.collectionViewSetup()
                return cell
            default:
                return UITableViewCell()
            }
            
        })
    }
    
    //Step - 3
    private func applySnapShot(){
        var snapShot = NSDiffableDataSourceSnapshot<sections,AnyHashable>()
        
        snapShot.appendSections([.myBalance,.sendMoney])
        snapShot.appendItems([walletDetails?.currentBalance], toSection: .myBalance)
        snapShot.appendItems([walletDetails!], toSection: .sendMoney)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
}

extension HomeViewController: UITableViewDelegate{

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 140
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 68))
//        headerView.backgroundColor = UIColor.systemBackground
//
//        let sectionLabel = UILabel()
//        sectionLabel.text = "Section 1"
//        sectionLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
//        sectionLabel.frame = CGRect(x: 24, y: 34 - sectionLabel.intrinsicContentSize.height / 2, width: sectionLabel.intrinsicContentSize.width + 12, height: sectionLabel.intrinsicContentSize.height)
//
//        headerView.addSubview(sectionLabel)
//        return headerView
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 68
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}



