//
//  Model.swift
//  TasksApp
//
//  Created by Dominic Furano on 4/17/15.
//  Copyright (c) 2015 Dominic Furano. All rights reserved.
//

import Foundation

protocol FinishedPresentingAuthViewControllerDelegate: class {
    func finishedPresentingAuthViewController()
}

class ListManager: NSObject {
    
    let tasksService: GTLServiceTasks = GTLServiceTasks()
    
    let kKeychainItemName : String = "TasksApp"
    let kClientID : String = "318945420422-gekskgfnhkgn0ik6pcplua3fq98esu3k.apps.googleusercontent.com"
    let kClientSecret : String = "jfOuSPHvhqdwh0e3b_CpZS5v"
    let scope = kGTLAuthScopeTasks
    
    private var taskLists: [TaskList] = []
    
    weak var finishedPresentingAuthViewControllerDelegate: FinishedPresentingAuthViewControllerDelegate? = nil
    
    
    override init() {
        super.init()
        
        tasksService.shouldFetchNextPages = true
        tasksService.retryEnabled = true
        
        tasksService.authorizer = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName(kKeychainItemName, clientID: kClientID, clientSecret: kClientSecret)
        
        fetchTaskLists()
    }
    
    var listsCount: Int {
        return taskLists.count
    }
    
    func taskListNameForIndex(index: Int) -> String {
        return taskLists[index].name
    }
    
    func newTaskList(name: String) {
        taskLists.append(TaskList(name: name))
    }
    
    func setTaskListName(forIndex index: Int, name: String) {
        taskLists[index].name = name
    }
    
    func isSignedIn() -> Bool {
        return tasksService.authorizer.canAuthorize!
    }
    
    func createAuthController() -> GTMOAuth2ViewControllerTouch {
        return GTMOAuth2ViewControllerTouch(scope: scope,
            clientID: kClientID,
            clientSecret: kClientSecret,
            keychainItemName: kKeychainItemName,
            delegate: self,
            finishedSelector: Selector("viewController:finishedWithAuth:error:"))
    }
    
    func viewController(viewController: GTMOAuth2ViewControllerTouch, finishedWithAuth authResult: GTMOAuth2Authentication, error: NSError?) {
        println("done presenting")
        if error != nil {
            println("Authentication Error")
            self.tasksService.authorizer = nil
        } else {
            println("Authentication Success")

            self.tasksService.authorizer = authResult
        }
        //fetchTaskLists()
        finishedPresentingAuthViewControllerDelegate?.finishedPresentingAuthViewController()
    }
    
    func fetchTaskLists() {
        let query: GTLQueryTasks = GTLQueryTasks.queryForTasklistsList() as! GTLQueryTasks
        
        tasksService.executeQuery(query,
            completionHandler: {
                (ticket, taskLists, error) -> Void in
                    println((taskLists as! GTLTasksTaskLists).items())
        })
    }
    
}

class TaskList {
    private var name: String
    private var tasks: [Task]
    
    init(name: String) {
        self.name = name
        self.tasks = []
    }
}

class Task {
    private(set) var name: String
    
    init(name: String) {
        self.name = name
    }
}









































