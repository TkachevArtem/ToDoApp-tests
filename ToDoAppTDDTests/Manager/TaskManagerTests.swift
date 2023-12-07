//
//  TaskManagerTests.swift
//  ToDoAppTDDTests
//
//  Created by Artem Tkachev on 31.10.23.
//

import XCTest
@testable import ToDoAppTDD

final class TaskManagerTests: XCTestCase {
    
    var sut: TaskManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TaskManager()
    }

    override func tearDownWithError() throws {
        sut.removeAll()
        sut = nil
        try super.tearDownWithError()
    }

    func testInitTaskManagerWithZeroTasks() {
        XCTAssertEqual(sut.tasksCount, 0)
    }
    
    func testInitTaskManagerWithZeroDoneTasks() {
        XCTAssertEqual(sut.doneTasksCount, 0)
    }
    
    func testAddTaskIncrementTasksCount() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        XCTAssertEqual(sut.tasksCount, 1)
    }
    
    func testTaskAtIndexIsAddedTask() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        let returnedTask = sut.task(at: 0)
        XCTAssertEqual(task.title, returnedTask.title)
    }
    
    func testCheckTaskAtIndexChangesCounts() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        sut.checkTask(at: 0)
        XCTAssertEqual(sut.tasksCount, 0)
        XCTAssertEqual(sut.doneTasksCount, 1)
    }
    
    func testCheckTaskRemovedFromTasks() {
        let firstTask = Task(title: "Foo")
        let secondTask = Task(title: "Bar")
        sut.add(task: firstTask)
        sut.add(task: secondTask)
        sut.checkTask(at: 0)
        XCTAssertEqual(sut.task(at: 0), secondTask)
    }
    
    func testDoneTaskAtReturnsCheckedTask() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        sut.checkTask(at: 0)
        let returnedTask = sut.doneTask(at: 0)
        XCTAssertEqual(returnedTask, task)
    }
    
    func testRemoveAllResultsCountsBeZero() {
        let firstTask = Task(title: "Foo")
        let secondTask = Task(title: "Bar")
        sut.add(task: firstTask)
        sut.add(task: secondTask)
        sut.checkTask(at: 0)
        sut.removeAll()
        XCTAssertTrue(sut.tasksCount == 0)
        XCTAssertTrue(sut.doneTasksCount == 0)
    }
    
    func testAddingSameObjectDoesNotIncrementCount() {
        let firstTask = Task(title: "Foo")
        let secondTask = Task(title: "Foo")
        sut.add(task: firstTask)
        sut.add(task: secondTask)
        XCTAssertTrue(sut.tasksCount == 1)
    }
    
    func testWhenTaskManagerRecreatedSavedTaskShouldBeEqual() {
        var taskManager: TaskManager! = TaskManager()
        let task = Task(title: "Foo")
        let task2 = Task(title: "Bar")
        taskManager.add(task: task)
        taskManager.add(task: task2)
        NotificationCenter.default.post(name: UIApplication.willResignActiveNotification, object: nil)
        taskManager = nil
        taskManager = TaskManager()
        XCTAssertEqual(taskManager.tasksCount, 2)
        XCTAssertEqual(taskManager.task(at: 0), task)
        XCTAssertEqual(taskManager.task(at: 1), task2)
    }

}
