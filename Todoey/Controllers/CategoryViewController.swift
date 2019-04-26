//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ruth Lycke on 4/24/19.
//  Copyright © 2019 tcmrestoration. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
   
    var categoryArray : Results<Category>?
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      loadCategories()
        tableView.separatorStyle = .none
        tableView.rowHeight = 80.0
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        
        if let category = categoryArray?[indexPath.row] {
            cell.textLabel?.text = category.name
            guard let categoryColor = UIColor(hexString: category.color) else {fatalError()}
        cell.backgroundColor = categoryColor
            
       cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
            
        }
//        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No CategoryArray Added Yet."
//        cell.backgroundColor = UIColor(hexString: categoryArray?[indexPath.row].color ?? "C4EDFD")
//        cell.delegate = self
        return cell
    }
    
    
    
    //MARK: - Data Manipulation Methods
    func save(category: Category) {
        do {
            try realm.write {
                
              realm.add(category)
        
            }
            
        } catch {
            print("Error saving categories \(error)")
        }
  tableView.reloadData()
}
    func loadCategories() {
         categoryArray = realm.objects(Category.self)
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//        do {
//      categoryArray = try context.fetch(request)
//
//        } catch {
//            print("Error loading categories \(error)")
//        }
        tableView.reloadData()
    }
    
    
    //MARK - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
       super.updateModel(at: indexPath)
        if let categoryForDeletion = self.categoryArray?[indexPath.row] {
                do {
                 try self.realm.write {
           // realm.delete(categoryArray[indexPath.row])
                    self.realm.delete(categoryForDeletion)
           }
        } catch {
           print("Error deleting category, \(error)")
            
             }
       }
    }
    
    @IBAction func addaButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
                let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
                let action = UIAlertAction(title: "Add", style: .default) { (action) in
                let newCategory = Category()
//                let newCategory = Category(context: self.context)
                    newCategory.name = textField.text!
                    newCategory.color = UIColor.randomFlat.hexValue()
                    
//                    self.categoryArray.append(newCategory)
                    self.save(category: newCategory)
        
                }
                  alert.addAction(action)
        
                  alert.addTextField { (field) in
        
                    textField = field
        
                    textField.placeholder = "Add a new category"
            }
            present(alert, animated: true, completion: nil)
        
    }
    //MARK: - TableView Degelate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
}
//MARK - Swipe Cell Delegate Methods
//extension CategoryViewController: SwipeTableViewCellDelegate {
//
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//            // handle action by updating model with deletion
//            if let categoryForDeletion = self.categoryArray?[indexPath.row] {
//            do {
//            try self.realm.write {
////                realm.delete(categoryArray[indexPath.row])
//                  self.realm.delete(categoryForDeletion)
//            }
//            } catch {
//                print("Error deleting category, \(error)")
//            }
////            print("Item deleted")
//        }
////            tableView.reloadData()
//        }
//        // customize the action appearance
//        deleteAction.image = UIImage(named: "delete-icon")
//
//        return [deleteAction]
//    }
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
////        options.transitionStyle = .border
//        return options
//    }

    
    
    

