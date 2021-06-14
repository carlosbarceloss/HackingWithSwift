//
//  ViewController.swift
//  Challenge1
//
//  Created by Carlos Barcelos on 07/06/21.
//

import UIKit

class ViewController: UITableViewController {

    var flags = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Bandeiras"
        navigationController?.navigationBar.prefersLargeTitles = true
        flags += ["alemanha", "espanha", "estonia", "estados unidos", "franca", "irlanda", "italia", "monaco", "nigeria", "polonia", "reino unido", "russia"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath) as! FlagTableViewCell
        cell.flagImageView.image = UIImage(named: flags[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Details") as? DetailsViewController {
            vc.selectedFlag = flags[indexPath.row]
            vc.flagTitle = "\(flags[indexPath.row].uppercased())"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

