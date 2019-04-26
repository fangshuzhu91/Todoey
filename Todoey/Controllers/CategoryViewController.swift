//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ruth Lycke on 4/24/19.
//  Copyright © 2019 tcmrestoration. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
   
    var categoryArray : Results<Category>?
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      loadCategories()
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No CategoryArray Added Yet."
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
    
    
    
    @IBAction func addaButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
                let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
                let action = UIAlertAction(title: "Add", style: .default) { (action) in
                let newCategory = Category()
//                let newCategory = Category(context: self.context)
                    newCategory.name = textField.text!
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

