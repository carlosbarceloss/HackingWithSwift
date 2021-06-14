//
//  ShopListTableViewController.swift
//  Challenge2 SHOPLIST
//
//  Created by Carlos Barcelos on 09/06/21.
//

import UIKit

class ShopListTableViewController: UITableViewController {
    
    var shopList = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearList))
        
    }
    
    @objc func clearList() {
        let ac = UIAlertController(title: "Atenção!", message: "A lista será apagada e os itens serão perdidos. Deseja continuar?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continuar", style: .default) {
            [weak self] _ in
            self?.shopList.removeAll()
            self?.tableView.reloadData()
        })
        ac.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func addNewItem(){
        let ac = UIAlertController(title: "Adicionar item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let addAction = UIAlertAction(title: "Adiconar", style: .default) {
            [weak self, weak ac] _ in
            guard let itemToAdd = ac?.textFields?[0].text else { return }
            self?.addItem(itemToAdd)
        }
        ac.addAction(addAction)
        present(ac, animated: true)
    }
    
    func addItem(_ item: String) {
        shopList.insert(Item(item), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shopList[indexPath.row].name
        return cell
    }
}
