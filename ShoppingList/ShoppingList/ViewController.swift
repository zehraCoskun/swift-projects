//
//  ViewController.swift
//  ShoppingList
//
//  Created by Zehra Coşkun on 3.05.2024.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addNewItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash,
                                                            target: self,
                                                            action: #selector(refreshList))
            
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
   

    @objc func addNewItem(){
        let ac = UIAlertController(title: "Enter item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submit = UIAlertAction(title: "Ok", style: .default){ [weak self, weak ac] _ in
            guard let newItem = ac?.textFields?[0].text else { return}
            self?.submit(newItem: newItem)
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(submit)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    func submit(newItem : String){
      let item = newItem.prefix(1).capitalized + newItem.dropFirst()
        shoppingList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .fade)
        
    }
    
    @objc func refreshList(){
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

}

