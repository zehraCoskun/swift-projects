//
//  ViewController.swift
//  Petitions
//
//  Created by Zehra Coşkun on 6.05.2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString : String
        
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self.parse(json: data)
                    self.setupNavigationBar()
                    return
                }
            }

            self.showError()
            self.setupNavigationBar()
        }
        
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showError() {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    func setupNavigationBar() {
        DispatchQueue.main.async{ [weak self] in
            self?.navigationItem.title = "Petitions"
            self?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                target: self,
                                                               action: #selector(self?.filterAction))
            self?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                                target: self,
                                                                action: #selector(self?.refreshAction))
        }
    }
    
    @objc func filterAction(){
        let ac = UIAlertController(title: "Filter",
                                   message: nil,
                                   preferredStyle: .alert)
        ac.addTextField()
        let filter = UIAlertAction(title: "Ok", style: .default){ [weak self, weak ac] _ in
            guard let filterWord = ac?.textFields?.first?.text else {return}
            self?.filter(filterWord: filterWord.lowercased())
            
        }
        ac.addAction(filter)
        present(ac, animated: true)
    }
    
    func filter(filterWord: String){
        var title: String
        filteredPetitions.removeAll(keepingCapacity: false)
        for petition in petitions {
            title = petition.title.lowercased()
            if  title.contains(filterWord){
                filteredPetitions.append(petition)
                tableView.reloadData()
            }
        }
    }
    
    @objc func refreshAction(){
        filteredPetitions = petitions
        tableView.reloadData()
    }
}
