
import UIKit

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    
    var checkedCell:Bool = true
    var todoItems: [TodoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        addButton.layer.cornerRadius = addButton.frame.height/2
        listTableView.register(UINib(nibName: "TodoItemTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoItemTableViewCell")
        listTableView.delegate = self
        listTableView.dataSource = self
        
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Add Todo Item", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Title"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Body"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let self = self else { return }
            if let title = alertController.textFields?.first?.text,
               let body = alertController.textFields?.last?.text {
                // Add the item locally
                let newItem = TodoItem(title: title, body: body)
                self.todoItems.append(newItem)
                DispatchQueue.main.async {
                    self.listTableView.reloadData()
                }
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func deleteCheckedItemsButtonTapped(_ sender: UIButton) {
        // Assuming `dataSource` is an array of `TodoItem` objects
        if let indexPaths = listTableView.indexPathsForSelectedRows {
            // Remove items from the data source
            let rowsToDelete = indexPaths.map { $0.row }.sorted(by: >)
            for row in rowsToDelete {
                todoItems.remove(at: row)
            }

            // Update the table view
            listTableView.deleteRows(at: indexPaths, with: .fade)

            // Reset the background color of selected cells
            for indexPath in indexPaths {
                let cell = listTableView.cellForRow(at: indexPath) as? TodoItemTableViewCell
                cell?.backgroundColor = nil // Reset to default color or clear
            }
        }
    }
}
extension ToDoViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemTableViewCell") as! TodoItemTableViewCell
        
        let item = todoItems[indexPath.row]
        cell.titleLabel.text = item.title
        cell.bodyLabel.text = item.body
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
    }


