//
//  ViewController.swift
//  Todoey
//
//  Created by Hussain Arthuna on 1/20/19.
//  Copyright © 2019 Hussain Arthuna. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

//    var itemArray = ["Find Mike", "Buy eggos", "Chicken"]
    var itemArray = [Item]()
    //let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadItems()
        
        
        
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

    //MARK - TableView Datasource methods
    
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
            
            let newItem = Item()
            newItem.title = textField.text!
            
            
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
        let encoder = PropertyListEncoder()
        
        do{
            
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
            //try data.write
            
        }
        catch{
            print("Error encoding \(error)")
        }
        
        // self.defaults.set(self.itemArray, forKey: "TodoListArray")
        
        tableView.reloadData()
        
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!){
        
            
            let decoder = PropertyListDecoder()
            
            do{
                
                itemArray = try decoder.decode([Item].self, from: data)
            
                
            }
            catch{
                print("Error Decoding \(error)")
            }
            
            
        }
        
    }

}

