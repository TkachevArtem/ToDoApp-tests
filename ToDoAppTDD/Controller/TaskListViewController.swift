//
//  ViewController.swift
//  ToDoAppTDD
//
//  Created by Artem Tkachev on 30.10.23.
//

import UIKit

class TaskListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var dataProvider: DataProvider!
    
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController {
            viewController.taskManager = self.dataProvider.taskManager
            //present(viewController, animated: true)
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let taskManager = TaskManager()
        dataProvider.taskManager = taskManager
        
        NotificationCenter.default.addObserver(self, selector: #selector(showDetail(withNotification:)), name: NSNotification.Name(rawValue: "DidSelectRow notification"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func showDetail(withNotification notification: Notification) {
        guard let userInfo = notification.userInfo,
              let task = userInfo["task"] as? Task,
              let detailViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self )) as? DetailViewController else {
            fatalError()
        }
        detailViewController.task = task
        navigationController?.pushViewController(detailViewController, animated: true)
    }

}

