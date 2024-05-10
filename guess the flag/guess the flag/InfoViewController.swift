//
//  InfoViewController.swift
//  Guess The Flag
//
//  Created by Zehra Coşkun on 10.05.2024.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet var flagImage: UIImageView!
    @IBOutlet var tableView: UITableView!
    
    var countries = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
     countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        flagImage.layer.borderWidth = 3
        flagImage.layer.cornerRadius = 8
    }

}
extension InfoViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.countryNameLabel.text = countries[indexPath.row].uppercased()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        flagImage.image = UIImage(named: countries[indexPath.row])
    }

    
    
}
