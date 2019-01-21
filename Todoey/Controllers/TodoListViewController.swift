//
//  ViewController.swift
//  Todoey
//
//  Created by Hussain Arthuna on 1/20/19.
//  Copyright © 2019 Hussain Arthuna. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController{

//    var itemArray = ["Find Mike", "Buy eggos", "Chicken"]
    var todoItems : Results<Item>?
    //let defaults = UserDefaults.standard
    let realm = try! Realm()
    var selectedCategory : Category? {
        
        didSet{
            
            loadItems()

        }
    }
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
        
//        let newItem1 = Item()
//        newItem1.title = "Find"
//        itemArray.append(newItem1)
//        
//        let newItem2 = Item()
//        newItem2.title = "ME"
//        itemArray.append(newItem2)
//        
//        let newItem3 = Item()
//        newItem3.title = "Asshole"
//        itemArray.append(newItem3)
        
        
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = items
//       }
        
    }

    //MARK: - TableView Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            
            
            cell.accessoryType = item.done ? .checkmark : .none
        }
        else{
            
            cell.textLabel?.text = "No Items Added"
        }
        
        
       
        
        //above line can replicate the below if else using tenary operator
        
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        }
//        else{
//            cell.accessoryType = .none
//        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
//
//        if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//        }
//        else{
//            itemArray[indexPath.row].done = false
//        }
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
       // todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        
        
        if let item = todoItems?[indexPath.row]{
            
            do{
                
                try realm.write {
                    
                    item.done = !item.done
                    
                }
                
            }
            catch{
                print("Error Changing status \(error)")
            }
        }
        
        tableView.reloadData()
        
        
        
        //saveData()
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen when user adds the item
            
            
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.done = false
                        newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                    }
                }
                catch{
                    print("Error \(error)")
                }
                
            }
            
            self.tableView.reloadData()
            
            
            
            
                //            newItem.parentCategory = self.selectedCategory
//            self.itemArray.append(newItem)

            //self.saveData()
            
            //print("Success")
           // print(textField.text)
            
        }
        
            alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            print(alertTextField)
        }
        
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        
        
    }
    
//    func saveData() {
//
//
//        do{
//            //try context.save()
////            let data = try encoder.encode(itemArray)
////            try data.write(to: dataFilePath!)
//
//            //try data.write
//
//        }
//        catch{
//           // print("Error Saving Context \(error)")
//        }
//
//        // self.defaults.set(self.itemArray, forKey: "TodoListArray")
//
//        tableView.reloadData()
//
//    }
//
    func loadItems() {

        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: false)
        
//       // let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate{
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        }
//        else{
//
//            request.predicate = categoryPredicate
//        }
//
////        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//
//       // request.predicate = compoundPredicate
//
//        do{
//
//            itemArray =  try context.fetch(request)
//        }
//        catch{
//
//            print("Error fetching data \(error)")
//        }
        tableView.reloadData()
    }

}

extension TodoListViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
        
        tableView.reloadData()
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        //request.predicate = predicate
//
//        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//
//        request.sortDescriptors = [sortDescriptor]
//
//        loadItems(with: request, predicate: predicate)
//
////        do{
////
////            itemArray =  try context.fetch(request)
////        }
////        catch{
////
////            print("Error fetching data \(error)")
////        }


    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            
            DispatchQueue.main.async {
                
                searchBar.resignFirstResponder()
            }
            
        }
    }
    
}


