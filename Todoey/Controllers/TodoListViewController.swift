//
//  ViewController.swift
//  Todoey
//
//  Created by Ruth Lycke on 4/22/19.
//  Copyright © 2019 tcmrestoration. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {
    var todoItems: Results<Item>?
   let  realm = try! Realm()
//     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    @IBOutlet weak var searchBar: UISearchBar!
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
        
    }
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
// var itemArray = ["Find Mike", "Buy Eggos", "Destory Demogorgon"]
//    let defaults = UserDefaults()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        tableView.separatorStyle = .none
        
        
        
        
       
//        print(dataFilePath)
        
        
//        let newItem = Item ()
//        newItem.title = "Find Mike"
////        newItem.done = true
//        itemArray.append(newItem)
//
//        let newItem2 = Item ()
//        newItem2.title = "Buy Eggos"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item ()
//        newItem3.title = "Destory Demogorgon"
//        itemArray.append(newItem3)
        
        //        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        loadItems()
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         title = selectedCategory?.name
        
        guard let colorHex = selectedCategory?.color else { fatalError() }
            
        updateNavBar(withHexCode: colorHex)
    
            }
    override func viewWillDisappear(_ animated: Bool) {
        //返回页面导航栏的颜色“009193”
//        guard let originalColor = UIColor(hexString: "009193") else {fatalError()}
//        navigationController?.navigationBar.barTintColor = originalColor
//        navigationController?.navigationBar.tintColor = FlatWhite()
//        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: FlatWhite()]
        updateNavBar(withHexCode: "009193")
        //替代上面的代码
        
    }//MARK - Nav Bar Setup Methods
    func  updateNavBar(withHexCode colorHexCode: String) {
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exit.")}
        guard let navBarColor = UIColor(hexString: colorHexCode) else { fatalError() }
        //               let navBarColor = FlatWhite()
        
        navBar.barTintColor = navBarColor
        navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColor, returnFlat: true)]
        
        searchBar.barTintColor = navBarColor
        
        
    }
           
    

    // Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems?.count ?? 1
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row] {
//        cell.textLabel?.text = itemArray[indexPath.row]
         cell.textLabel?.text = item.title
            
            if let color = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {
            cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
//               cell.backgroundColor = FlatSkyBlue().darken(byPercentage: CGFloat(indexPath.row / todoItems?.count)
                //currently on row 5
                //there's a total of 10 items in todoitems
            
            }
            
//            print("version 1: \(CGFloat(indexPath.row / todoItems!.count))")
//            print("version 2: \(CGFloat(indexPath.row) / CGFloat(todoItems!.count))")
        //cell.textLabel?.text = itemArray[indexPath.row].title
        
        //Ternary operator==>
        //value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
            
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
//        if item.done == true {
//            //if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
    return cell
        
    }
    //Tableview Delegete Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let item = todoItems?[indexPath.row] {
            do {
            try realm.write {
                item.done = !item.done
//                realm.delete(item)
                }
                
            }
            catch {
                print("Error saving done status, \(error)")
            }
        }
//        print(itemArray[indexPath.row])
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        
         //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        
//        itemArray[indexPath.row].setValue("Completed", forKey: "title")
        
//        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        
//        if  itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
//
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
//        } else {
//             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//        saveItems()
//      self.tableView.reloadData()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add new Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
       let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once user clicks the Add Item button on our UIAlter
//            print("Success")
//            print(textField.text)
            if let currentCategory = self.selectedCategory {
                do {
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                }
               
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            self.tableView.reloadData()
//            let newItem = Item()
//            newItem.title = textField.text!
          
//            let newItem = Item(context: self.context)
//            newItem.title = textField.text!
//            newItem.done = false
//            newItem.parentCategory = self.selectedCategory
//            self.itemArray.append(newItem)
            
           
//          self.itemArray.append(textField.text!)
            
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
           
//            let encoder = PropertyListEncoder()
//
////            let data = encoder.encode(itemArray)
//            do {
//                let data = try encoder.encode(self.itemArray)
//
//                try data.write(to: self.dataFilePath!)
//            } catch {
//                print("Error endcoding item array, \(error)")
//            }
////            do {
////            let data = try encoder.encode(self.itemArray)
////                try data.write(to: self.dataFilePath!)
////
//           self.tableView.reloadData()
//            // after add this code reloaddata the new item we add will appear to the tableview
//            } catch {
//
            }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
//            print(alertTextField.text)
            textField = alertTextField
            
//            print(alertTextField)
//            print("now")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
            
        
    }
    
    //MARK: - Model Manuplation Methods
//    func saveItems() {
////        let encoder = PropertyListEncoder()
//
//        //            let data = encoder.encode(itemArray)
//        do {
//            try context.save()
////            let data = try encoder.encode(itemArray)
//
////            try data.write(to: dataFilePath!)
//        } catch {
//            print("Error saving context, \(error)")
////            print("Error endcoding item array, \(error)")
//        }
//         self.tableView.reloadData()
//    }
//
    
    func loadItems () {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
////        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
////        request.predicate = compoundPredicate
//        if let addtionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//        do {
//        itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
    tableView.reloadData()
}
    override func updateModel(at indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            
            do {
           try realm.write {
                realm.delete(item)
            }
        }
        catch {
            print("Error deleting Item, \(error)")
        
        }
    }
}
}
//MARK: - Search Bar Methods
    extension TodoListViewController : UISearchBarDelegate {

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
            todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)

//            let request : NSFetchRequest<Item> = Item.fetchRequest()
////                 print(searchBar.text!)
//
//            let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
////            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
////             sortDescriptr = NSSortDescriptor(key: "title", ascending: true)
//            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//            loadItems(with : request, predicate: predicate)
//            do {
//                itemArray = try context.fetch(request)
//            } catch {
//                print("Error fetching data from context \(error)")
//            }
            tableView.reloadData()


        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text?.count == 0 {
                loadItems()
                DispatchQueue.main.async {

                     searchBar.resignFirstResponder()
                }

            }
        }
    }

