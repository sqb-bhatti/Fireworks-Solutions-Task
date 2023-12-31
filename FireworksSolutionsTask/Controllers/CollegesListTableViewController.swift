//
//  CollegesListTableViewController.swift
//  FireworksSolutionsTask
//
//  Created by Saqib Bhatti on 28/12/23.
//

import Foundation
import UIKit


class CollegesListTableViewController: UITableViewController {
    // MARK: ViewModel
    private var collegeListVM = CollegeListViewModel(colleges: [College]())
//    var vm = WebPageViewModel()
    
    var country_name = ""
    let cellId = "CollegeTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List"
        
        callGetUniversitiesAPI()
    }
    
    func callGetUniversitiesAPI() {
        collegeListVM.getColleges(for: country_name) { (names) in
            if let names = names {
                self.collegeListVM.colleges = names.colleges
                self.tableView.reloadData()
            }
        }
    }
}



extension CollegesListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collegeListVM.numberOfRowsInSection()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = self.collegeListVM.collegeAtIndex(indexPath.row)
        
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) else {
                return UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellId)
            }
            return cell
        }()
        cell.textLabel?.text = vm.name
        cell.detailTextLabel?.text = vm.country
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebPageViewController") as? WebPageViewController {
            viewController.web_link = self.collegeListVM.collegeAtIndex(indexPath.row).college.web_pages[0]
            
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
}
