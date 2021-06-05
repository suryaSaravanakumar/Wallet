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
    var totalMySpendRowsCount = 0
    
    enum sections {
        case sendMoney
        case myBalance
        case mySpends
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
        self.tableView.register(UINib(nibName: SendMoneyTabelCell.SendMoneyTabelCell_ID, bundle: nil), forCellReuseIdentifier: SendMoneyTabelCell.SendMoneyTabelCell_ID)
        self.tableView.register(UINib(nibName: MySpendsTableViewCell.MySpendsTableViewCell_ID, bundle: nil), forCellReuseIdentifier: MySpendsTableViewCell.MySpendsTableViewCell_ID)
        
        configuareTableViewDataSource()
    }
    
    private func prepareData() {
        guard let walletData = readLocalFileAndParseData() else {return}
        walletDetails = walletData //.append(walletData)
        totalMySpendRowsCount = walletDetails?.mySpend.count ?? 0
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
                let cell = tableView.dequeueReusableCell(withIdentifier: SendMoneyTabelCell.SendMoneyTabelCell_ID, for: indexpath) as? SendMoneyTabelCell
                cell?.selectionStyle = .none
                cell?.friendsDetails = self.walletDetails?.friendsList
                cell?.collectionViewSetup()
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: MySpendsTableViewCell.MySpendsTableViewCell_ID, for: indexpath) as? MySpendsTableViewCell
                if let mySpend = walletDetails as? MySpend{
                    cell?.mySpendsData = mySpend
                    cell?.mySpendCellSetup()
                }
                
                let isFirstCell = indexpath.row == 0
                let isLastCell = indexpath.row == self.totalMySpendRowsCount - 1

                    if isFirstCell {
                        cell?.viewHolderView.layer.cornerRadius = 20
                        cell?.viewHolderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

                    }
                if isLastCell {
                    cell?.viewHolderView.layer.cornerRadius = 20
                    cell?.viewHolderView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
                    }
                return cell
            default:
                return UITableViewCell()
            }
            
        })
    }
    
    //Step - 3
    private func applySnapShot(){
        var snapShot = NSDiffableDataSourceSnapshot<sections,AnyHashable>()
        
        snapShot.appendSections([.myBalance,.sendMoney,.mySpends])
        snapShot.appendItems([walletDetails?.currentBalance], toSection: .myBalance)
        snapShot.appendItems([walletDetails!], toSection: .sendMoney)
        snapShot.appendItems(walletDetails!.mySpend, toSection: .mySpends)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
}

extension HomeViewController: UITableViewDelegate{

  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 50))

        switch section {
        case 1:
            let sectionLabel = UILabel()
            sectionLabel.translatesAutoresizingMaskIntoConstraints = false
            sectionLabel.text = "Send Money"
            sectionLabel.font = UIFont(name: "Lato-Bold", size: 16)
            headerView.addSubview(sectionLabel)
            //Adding constraints
            sectionLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15).isActive = true
            sectionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            sectionLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16).isActive = true
            
            let sectionButton = UIButton()
            sectionButton.translatesAutoresizingMaskIntoConstraints = false
            sectionButton.setImage(#imageLiteral(resourceName: "scan"), for: .normal)
            headerView.addSubview(sectionButton)
            //Adding constraints
            sectionButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16).isActive = true
            sectionButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
            sectionButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
            sectionButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
            return headerView
        case 2:
            let sectionLabel = UILabel()
            sectionLabel.translatesAutoresizingMaskIntoConstraints = false
            sectionLabel.text = "My Spends"
            sectionLabel.font = UIFont(name: "Lato-Bold", size: 16)
            headerView.addSubview(sectionLabel)
            //Adding constraints
            sectionLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15).isActive = true
            sectionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            sectionLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16).isActive = true
            
            let sectionButton = UIButton()
            sectionButton.translatesAutoresizingMaskIntoConstraints = false
            sectionButton.setTitle("SEE ALL", for: .normal)
            sectionButton.setTitleColor(.black, for: .normal)
            sectionButton.titleLabel?.font = UIFont(name: "Lato-Bold", size: 16)
            headerView.addSubview(sectionButton)
            //Adding constraints
            sectionButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16).isActive = true
            sectionButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
            return headerView
        default:
            return UIView()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}



