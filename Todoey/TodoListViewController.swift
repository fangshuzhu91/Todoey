//
//  ViewController.swift
//  Todoey
//
//  Created by Ruth Lycke on 4/22/19.
//  Copyright © 2019 tcmrestoration. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
 var itemArray = ["Find Mike", "Buy Eggos", "Destory Demogorgon"]
    let defaults = UserDefaults()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
        
        
        // Do any additional setup after loading the view.
    }
    // Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
    return cell
        
    }
    //Tableview Delegete Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none

        } else {
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }

        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Mark - Add new Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
       let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once user clicks the Add Item button on our UIAlter
//            print("Success")
//            print(textField.text)
          self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
           self.tableView.reloadData()
            // after add this code reloaddata the new item we add will appear to the tableview
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat new item"
//            print(alertTextField.text)
            textField = alertTextField
            
//            print(alertTextField)
//            print("now")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

