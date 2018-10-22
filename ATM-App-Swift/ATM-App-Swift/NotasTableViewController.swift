//
//  NotasTableViewController.swift
//  ATM-App-Swift
//
//  Created by Marcos Matsuda on 22/10/2018.
//  Copyright © 2018 Marcos Matsuda. All rights reserved.
//

import UIKit
import CoreData

class NotasTableViewController: UITableViewController {
    
    var fetchResultsController: NSFetchedResultsController<Notas>!

    override func viewDidLoad() {
        super.viewDidLoad()
        carregaNotas()
    }
    
    @IBAction func btDeleteAll(_ sender: Any) {
        //getting context from your Core Data Manager Class
        let managedContext = self.getContext()
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Notas")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
            
            //falta atualizar a tableview...
            
        } catch {
            print ("There is an error in deleting records")
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        }
            return appDelegate.persistentContainer.viewContext
    }
    func carregaNotas(){
        let fetchRequest: NSFetchRequest<Notas> = Notas.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "valor", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController.delegate = self

        do{
            try fetchResultsController.performFetch()
            print(try fetchResultsController.performFetch())

        }catch{
            print(error.localizedDescription)
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = fetchResultsController.fetchedObjects?.count ?? 0
        return count
        
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotasTableViewCell

        guard let nota = fetchResultsController.fetchedObjects?[indexPath.row] else {
            return cell
        }
        
        cell.prepare(with: nota)
        return cell
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NotasTableViewController: NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print("teste")
        tableView.reloadData()
    }
}
