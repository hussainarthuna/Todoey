//
//  ViewController.swift
//  Todoey
//
//  Created by Hussain Arthuna on 1/20/19.
//  Copyright © 2019 Hussain Arthuna. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController{

//    var itemArray = ["Find Mike", "Buy eggos", "Chicken"]
    var itemArray = [Item]()
    //let defaults = UserDefaults.standard
    
    var selectedCategory : Category? {
        
        didSet{
            
            loadItems()

        }
    }
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
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
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        
        cell.textLabel?.text = item.title
        
        
        cell.accessoryType = item.done ? .checkmark : .none
        
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
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        
        
        saveData()
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
            
            
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            
            self.saveData()
            
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
    
    func saveData() {
        
        
        do{
            try context.save()
//            let data = try encoder.encode(itemArray)
//            try data.write(to: dataFilePath!)
            
            //try data.write
            
        }
        catch{
            print("Error Saving Context \(error)")
        }
        
        // self.defaults.set(self.itemArray, forKey: "TodoListArray")
        
        tableView.reloadData()
        
    }
    
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {

       // let request : NSFetchRequest<Item> = Item.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        }
        else{
            
            request.predicate = categoryPredicate
        }
        
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
        
       // request.predicate = compoundPredicate
        
        do{
            
            itemArray =  try context.fetch(request)
        }
        catch{
            
            print("Error fetching data \(error)")
        }
        tableView.reloadData()
    }

}

extension TodoListViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        //request.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        loadItems(with: request, predicate: predicate)
        
//        do{
//
//            itemArray =  try context.fetch(request)
//        }
//        catch{
//
//            print("Error fetching data \(error)")
//        }
        
        
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


