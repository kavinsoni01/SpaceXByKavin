//
//  UpcomingListViewController.swift
//  SpaceX Fan
//
//  Created by Kavin Soni on 27/06/21.
//

import UIKit

class UpcomingListViewController: BaseViewController{
//Variable
    var refreshControl = UIRefreshControl()
    private var viewModel:UpcomingListViewModel!

    
    //Outlets
    @IBOutlet weak var tblUpcomingList: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.viewModel = UpcomingListViewModel(output: self)
        self.viewModel.fetchUpcomingRockets()     
    }
    
    //MARK: Setup UI
    func setupUI() -> Void {
        
        self.setTitleNavigationController(text: "Upcoming launches")
        self.tblUpcomingList.delegate = self
        self.tblUpcomingList.dataSource = self
        self.tblUpcomingList.register(UINib.init(nibName: "RocketListingTableCell", bundle: nil), forCellReuseIdentifier: "RocketListingTableCell")
        self.tblUpcomingList.separatorStyle = .none
    }
   
}


extension UpcomingListViewController: UpcomingListViewModelOutputProtocol {
    func didReceive(rocketsInfo: [UpcomingLaunches]) {
        print(rocketsInfo)
              DispatchQueue.main.async {
                  self.tblUpcomingList.reloadData()
              }
    }

    func didFailToReceiveRocketsInfo(withError error: Error) {
        print(error)
    }
}


extension UpcomingListViewController:UITableViewDataSource{
    //MARK: Tableview Datasource
    //set how many cell in section

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.viewModel.rockets.count > 0{
            tableView.backgroundView = nil
            return self.viewModel.rockets.count
        } else {
            // Display a message when the table is empty
            self.createEmptyTableView(tblView: tableView)
            return self.viewModel.rockets.count
        }
    }
    //set table cell UI

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:RocketListingTableCell = tableView.dequeueReusableCell(withIdentifier: "RocketListingTableCell") as! RocketListingTableCell
        cell.selectionStyle = .none
        cell.btnFav.isHidden = true

        //setup table cell
        if self.viewModel.rockets.count > indexPath.row {
            cell.setupUpcomingCell(objModel: self.viewModel.rockets[indexPath.row])
        }
        
        return cell
    }
}

extension UpcomingListViewController:UITableViewDelegate{
    //MARK: Tableview Delegate Method
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsView:DetailsViewController = UIStoryboard(storyboard: .Main).instantiateViewController()
           detailsView.hidesBottomBarWhenPushed = true
        detailsView.isFromUpcoming = true
        detailsView.upcomingLaunchesModel = self.viewModel.rockets[indexPath.row]
        self.navigationController?.pushViewController(detailsView, animated: true)
    }
//
}
