//
//  DummyModel.swift
//  TasksApp
//
//  Created by Dominic Furano on 4/17/15.
//  Copyright (c) 2015 Dominic Furano. All rights reserved.
//

import Foundation

class ListManager {
    
    private var taskLists: [TaskList] = []
    
    
    init() {
        taskLists.append(TaskList(name: "Spam"))
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
