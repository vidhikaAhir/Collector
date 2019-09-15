//
//  ItemsTableViewController.swift
//  Collector
//
//  Created by Demo on 15/09/19.
//  Copyright © 2019 vidhika. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    
    var items : [Item] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getItems()
    }
    
    func getItems(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            
            if let coreDataStuff = try? context.fetch(Item.fetchRequest()) as? [Item]{
                if let coreDataItems : [Item] = coreDataStuff {
                    
                    items = coreDataItems
                    tableView.reloadData()
                    
                }
            }
            
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let item = items[indexPath.row]
        cell.textLabel?.text = item.titledb
        
        if let imageData = item.imagedb{
            
            cell.imageView?.image = UIImage(data: imageData)
        }
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
                let item = items[indexPath.row]
                context.delete(item)
                getItems()
                
            }
        }
    }
}
