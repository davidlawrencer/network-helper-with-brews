//
//  ViewController.swift
//  brewery-app-with-wrappers
//
//  Created by David Rifkin on 9/5/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var brewskis = [Brewery]() {
        didSet{
            brewTableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brewskis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let brewery = brewskis[indexPath.row]
        let cell = brewTableView.dequeueReusableCell(withIdentifier: "brewCell", for: indexPath)
        cell.textLabel?.text = brewery.name
        cell.detailTextLabel?.text = "\(brewery.city), \(brewery.state)"
        return cell
    }
    

    @IBOutlet weak var brewTableView: UITableView!
    
    
    
    private func loadData(){
        Brewery.getBrewskis { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let brewskis):
                    self.brewskis = brewskis
                }
            }
        }
    }
    
    override func viewDidLoad() {
        brewTableView.delegate = self
        brewTableView.dataSource = self
        loadData()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

