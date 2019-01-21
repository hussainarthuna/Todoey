//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Hussain Arthuna on 1/21/19.
//  Copyright © 2019 Hussain Arthuna. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 80.0

    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
      //  cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        
        cell.delegate = self
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            print("Delete Cell")
            
            self.updateModel(at: indexPath)
//            if let categoryForDeletion = self.categories?[indexPath.row]{
//                do{
//                    try self.realm.write {
//
//                        self.realm.delete(categoryForDeletion)
//                    }
//                }
//                catch{
//                    print("Error deleting")
//                }
//
//                tableView.reloadData()
//            }
            
            
            
            
            
            
            
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        //options.transitionStyle = .border
        return options
    }
    
    func updateModel(at indexPath : IndexPath){
        
    }

}
