//
//  TaskListsViewController.swift
//  TasksApp
//
//  Created by Dominic Furano on 4/17/15.
//  Copyright (c) 2015 Dominic Furano. All rights reserved.
//

import UIKit

class TaskListsViewController: UITableViewController {
    
    var listManager = ListManager()
    var addingNewList: Bool = false
    
    let tasksService: GTLServiceTasks = GTLServiceTasks()
    
    let kKeychainItemName : String = "TasksApp"
    let kClientID : String = "318945420422-i3kd09fanhadqgkth9u1tdfrpkbvf3mc.apps.googleusercontent.com"
    let kClientSecret : String = "yjrFwfKmjja816XJs2RRZPcH"
    let scope = "https://www.googleapis.com/auth/plus.me"
    
    
    override func loadView() {
        view = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /* Navigation bar */
        
        navigationItem.title = "Task Lists"
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: nil, action: nil)
        navigationItem.rightBarButtonItem = editButtonItem()
        
        
        /* Navigation toolbar */
        
        navigationController?.toolbarHidden = false
        
        //let flexibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        //let newTasksListButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addingNewTaskList")
        
        //toolbarItems = [flexibleSpace, newTasksListButton, flexibleSpace]

        
        
        //view.backgroundColor = UIColor.blackColor()
        //navigationController?.toolbar.backgroundColor = UIColor.blackColor()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        self.tasksService.authorizer = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName(kKeychainItemName, clientID: kClientID, clientSecret: kClientSecret)
        
        if !isSignedIn() {
            navigationController?.navigationBarHidden = true
            navigationController?.pushViewController(createAuthController(), animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isSignedIn() -> Bool {
        return tasksService.authorizer.canAuthorize!
    }

    func createAuthController() -> GTMOAuth2ViewControllerTouch {
        return GTMOAuth2ViewControllerTouch(scope: scope,
            clientID: kClientID,
            clientSecret: kClientSecret,
            keychainItemName: self.kKeychainItemName,
            delegate: self,
            finishedSelector: Selector("viewController:finishedWithAuth:error:"))
    }
    
    func viewController(viewController: GTMOAuth2ViewControllerTouch, finishedWithAuth authResult: GTMOAuth2Authentication, error:NSError?) {
        println("done presenting")
        if error != nil {
            println("Authentication Error")
            self.tasksService.authorizer = nil
        } else {
            println("Authentication Success")
            self.tasksService.authorizer = authResult
        }
        navigationController?.navigationBarHidden = false
    }

    

    



    

    
    /* TableView Delegate */
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        // TODO maybe
        return []
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        // TODO
        return UITableViewCellEditingStyle.Insert
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // TODO
    }
    
    override func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // TODO menu
        // tap hold
        return false
    }
    
    
    
    /* TableView Data Source */
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        cell.textLabel?.text = listManager.taskListNameForIndex(indexPath.row)
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listManager.listsCount
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
        // TODO
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // TODO
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // TODO
        return true
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // TODO
    }
    
    
    
    


}


































