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
    private var dataSource: UITableViewDiffableDataSource<sections,sendMoney>!
    private var sendMoneyList = [sendMoney(userName: "Surya",id: 0),
                                 sendMoney(userName: "Ram",id: 1),
                                 sendMoney(userName: "Tamil",id: 2),
                                 sendMoney(userName: "Miruthu",id: 3)]
    private var sendMoneyList1 = [sendMoney(userName: "Surya",id: 4),
                                 sendMoney(userName: "Jerlin",id: 5),
                                 sendMoney(userName: "Tamil",id: 6),
                                 sendMoney(userName: "Miruthu",id: 7)]
    enum sections{
        case sendMoney
        case myBalance
    }
 
    //MARK:- IBOutlet Declaration
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
       initalSetup()
    }

    override func viewDidAppear(_ animated: Bool) {
        applySnapShot()
    }
    
    //MARK:- Custom Methods
    private func initalSetup(){
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: CurrentBalanceTableViewCell.CurrentBalanceCell_ID, bundle: nil), forCellReuseIdentifier: CurrentBalanceTableViewCell.CurrentBalanceCell_ID)
        configuareTableViewDataSource()
    }
    
    //Step - 2
    private func configuareTableViewDataSource(){
        dataSource = UITableViewDiffableDataSource<sections,sendMoney>(tableView: tableView, cellProvider: { (tableView, indexpath, sendMoney) -> CurrentBalanceTableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrentBalanceTableViewCell.CurrentBalanceCell_ID, for: indexpath) as? CurrentBalanceTableViewCell
            cell?.userName.text = sendMoney.userName
            return cell
        })
    }
    
    //Step - 3
    private func applySnapShot(){
        var snapShot = NSDiffableDataSourceSnapshot<sections,sendMoney>()
        
        snapShot.appendSections([.myBalance,.sendMoney])
        snapShot.appendItems(sendMoneyList, toSection: .myBalance)
        
        
        snapShot.appendItems(sendMoneyList1, toSection: .sendMoney)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 68))
        headerView.backgroundColor = UIColor.systemBackground
        
        let sectionLabel = UILabel()
        sectionLabel.text = "Section 1"
        sectionLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        sectionLabel.frame = CGRect(x: 24, y: 34 - sectionLabel.intrinsicContentSize.height / 2, width: sectionLabel.intrinsicContentSize.width + 12, height: sectionLabel.intrinsicContentSize.height)
        
        headerView.addSubview(sectionLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 68
    }
}

