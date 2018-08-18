//
//  CityListViewController.swift
//  Cities
//
//  Created by Rafael Nascimento on 18/08/18.
//  Copyright © 2018 Rafael Nascimento. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    private var cities: [City] = [City]()
    private var filteredCities = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavBarImage()
        self.loadDataSource()
        self.setUpSearchController()
    }
    
    private func setUpSearchController() {
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        searchController.searchBar.delegate = self
    }
    
    private func addNavBarImage() {
        let navController = navigationController!
        let image = #imageLiteral(resourceName: "pin")
        let imageView = UIImageView(image: image)
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    private func loadDataSource() {
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let result = try JSONDecoder().decode([City].self, from: data)
                cities = result
                cities = cities.sorted(by: { $0.customName! < $1.customName! })
                for c in cities {
                    print(c.customName ?? "")
                }
                filteredCities = cities
                tableView.reloadData()
            } catch {
                // handle error
            }
        }
    }
}

extension CityListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCities = (cities.filter({ ($0.customName?.lowercased().hasPrefix(searchText.lowercased()))! }))
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredCities = (cities.filter({ ($0.customName?.lowercased().hasPrefix(""))! }))
        tableView.reloadData()
    }
}

extension CityListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReusableId")
        let city = filteredCities[indexPath.row]
        cell?.textLabel?.text = city.customName
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = filteredCities[indexPath.row]
        let cityCoodVC: CityCoordinateViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityCoordinateVC") as! CityCoordinateViewController
        cityCoodVC.city = city
        navigationController?.pushViewController(cityCoodVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
