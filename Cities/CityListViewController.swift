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
    private var filteredCities = [City]()
    private var cities: [City] = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavBarImage()
        self.setUpSearchController()
        self.loadDataSource()
        tableView.reloadData()
    }
    
    private func setUpSearchController() {
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cities"
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
    
    func loadDataSource() {
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                cities = try JSONDecoder().decode([City].self, from: data)
                
                // Sort cities in alphabetical order by name
                cities = cities.sorted(by: { $0.name < $1.name })
                
                filteredCities = cities
            } catch {
                let alert = UIAlertController(title: "Error", message: "Something went wrong when reading the city list. Please, try to run the app again.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func search(searchText: String) -> [City] {
        return (cities.filter({ ($0.name.lowercased().hasPrefix(searchText.lowercased())) }))
    }
}

extension CityListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCities = search(searchText: searchText)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredCities = search(searchText: "")
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
        cell?.textLabel?.text = "\(city.name), \(city.country)"
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
