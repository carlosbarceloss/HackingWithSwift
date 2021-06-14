//
//  PetitionViewController.swift
//  Project7
//
//  Created by Carlos Barcelos on 09/06/21.
//

import UIKit

class PetitionViewController: UITableViewController {

    var petitions = [Petition]()
    var urlString = ""
    var filteredPetitions = [Petition]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showCredits))
        let filterResultsButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filterResults))
        let reloadPetitionsButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadPetitions))
        navigationItem.rightBarButtonItems = [filterResultsButton, reloadPetitionsButton]
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self , from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.reloadData()
        }
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Créditos", message: "Os dados da página vem do website: \(urlString)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func filterResults() {
        let ac = UIAlertController(title: "Filtrar por palavra", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let filterAction = UIAlertAction(title: "Filtrar", style: .default) {
            [weak self, weak ac] _ in
            guard let keyword = ac?.textFields?[0].text?.lowercased() else { return }
            self?.reloadFilteredResults(with: keyword)
        }
        ac.addAction(filterAction)
        present(ac, animated: true)
    }
    
    func reloadFilteredResults(with keyword: String) {
        filteredPetitions.removeAll(keepingCapacity: true)
        for petition in petitions {
            if petition.title.lowercased().contains(keyword) || petition.body.lowercased().contains(keyword) {
                filteredPetitions.append(petition)
            }
        }
        tableView.reloadData()
    }
    
    @objc func reloadPetitions() {
        filteredPetitions.removeAll(keepingCapacity: true)
        filteredPetitions = petitions
        tableView.reloadData()
    }
    
    func showError() {
        let ac = UIAlertController(title: "Erro ao carregar", message: "Ocorreu um problema ao tentar carregar essa página. Por favor, verifique sua conexão e tente novamente.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
    }
     
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPetitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem =  petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
