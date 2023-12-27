//
//  SearchViewController.swift
//  FireworksSolutionsTask
//
//  Created by Saqib Bhatti on 27/12/23.
//

import UIKit
import CoreLocation

protocol SearchViewControllerDelegate: AnyObject {
    func searchViewController(_ vc: SearchViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?)
}


class SearchViewController: UIViewController {
    // MARK: ViewModel
    var vm = SearchViewModel()
    
//    var locations = [Location]()
    weak var delegate: SearchViewControllerDelegate?
    
    private let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        return field
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        tableView.delegate = self
        tableView.dataSource = self
        field.delegate = self
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        label.sizeToFit()
        label.frame = CGRect(x: 10, y: 10, width: label.frame.size.width, height: label.frame.size.height)
        field.frame = CGRect(x: 10, y: label.frame.size.height + 20, width: view.frame.size.width - 20, height: 50)
        let tableY: CGFloat = field.frame.origin.y + field.frame.size.height + 5
        tableView.frame = CGRect(x: 10, y: tableY,
                                 width: view.frame.size.width,
                                 height: view.frame.size.height - tableY)
    }
    
    private func setupUI() {
        view.addSubview(label)
        view.addSubview(field)
        view.addSubview(tableView)
        
        label.text = vm.labelText
        label.font = vm.labelFont
        field.placeholder = vm.textFieldText
        field.backgroundColor = vm.textFieldBackgroundColor
        field.leftView = vm.textFieldLeftView
        field.leftViewMode = vm.textFieldMode
        field.layer.cornerRadius = vm.textFieldCornerRadius
        tableView.backgroundColor = vm.tableViewBackgroundColor
    }
}



extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        field.resignFirstResponder()
        if let text = textField.text, !text.isEmpty {
            LocationManager.shared.findLocations(with: text) { [weak self] locations in
                DispatchQueue.main.async {
                    self?.vm.locations = locations
                    self?.tableView.reloadData()
                }
            }
        }
        return true
    }
}




extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfLocations
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = vm.locations[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        cell.contentView.backgroundColor = .secondarySystemBackground
        cell.backgroundColor = .secondarySystemBackground
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Notify Map controller to show pin at selected place
        let coordinate = vm.locations[indexPath.row].coordinates
        delegate?.searchViewController(self, didSelectLocationWith: coordinate)
    }
}
