//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Ruth Lycke on 4/26/19.
//  Copyright © 2019 tcmrestoration. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0

        
    }
    
    //Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
//        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No CategoryArray Added Yet."
//        
                cell.delegate = self
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.updateModel(at: indexPath)
            
//            print("Delete Cell")
//
////            if let categoryForDeletion = self.categoryArray?[indexPath.row] {
//                do {
//                    try self.realm.write {
//                        //                realm.delete(categoryArray[indexPath.row])
//                        self.realm.delete(categoryForDeletion)
//                    }
//                } catch {
//                    print("Error deleting category, \(error)")
//                }
//                //            print("Item deleted")
//            }
            //            tableView.reloadData()
        }
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        //        options.transitionStyle = .border
        return options
    }
    
    
    func updateModel (at indexPath : IndexPath) {
       print("Items Deleted From Superclass")
    }
}
