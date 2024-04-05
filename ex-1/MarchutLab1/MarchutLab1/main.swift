//
//  main.swift
//  MarchutLab1 - BTS tree
//
//  Created by Jakub Marchut on 11/03/2024.
//

import Foundation

class Node{
    var key: Int
    var value: Any
    var leftChild: Node?
    var rightChild: Node?
    weak var upper: Node?
    
    init(key: Int, value: Any, upper: Node?){
        self.key = key
        self.value = value
        self.upper = upper
        
        print("New node with id=\(self.key) has been created!")
    }
    deinit{
        print("Node with id=\(self.key) has been removed ")
    }
}

class BinarySearchTree {
    var root: Node?
    
    init(){
        print("New container has been created!")
    }
    deinit{
        print("Container has been removed")
    }
    
    func printBST(){
        printBSTRec(root: root)
    }
    func printBSTRec(root: Node?){
        if let root = root{
            printBSTRec(root: root.leftChild)
            print("node: \(root.key) \(root.value) with parent id:\(root.upper?.key ?? -1)")
            printBSTRec(root: root.rightChild)
        }
    }
    func addNode(key: Int, value: Any){
        root = addNodeRec(root: root, key: key, value: value, upper: nil)
    }
    func addNodeRec(root: Node?, key: Int, value: Any, upper: Node?) -> Node{
        if let root = root{
            if key < root.key {
                root.leftChild = addNodeRec(root: root.leftChild, key: key, value: value, upper: root)
            }
            else{
                root.rightChild = addNodeRec(root: root.rightChild, key: key, value: value, upper: root)
            }
            return root
        }
        else{
            return Node(key: key, value: value, upper: upper)
        }
    }
}


var tree:BinarySearchTree? = BinarySearchTree()
tree?.addNode(key: 1, value: "Coffee")
tree?.addNode(key: 3, value: "Tea")
tree?.addNode(key: 2, value: "Orange juice")
tree?.addNode(key: 4, value: "Water")

tree?.printBST()

tree = nil
