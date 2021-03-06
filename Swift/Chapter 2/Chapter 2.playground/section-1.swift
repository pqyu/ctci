// Cracking the coding interview
// Chapter 2 

import Foundation

// MARK: Simple Linked list implementation
class Node {
    var data: Int
    var next: Node?
    
    init(data:Int) {
        self.data = data
    }
    
    func addToTailWithData(data:Int) -> Node {
        var next = Node(data: data)
        var node = self
        while (node.next != nil) {
            node = node.next!
        }
        node.next = next
        
        return next
    }
    
    func deleteNode() ->  Node? {
        var node: Node? = self
        if let next = self.next {
            node!.data = next.data
            node!.next = next.next
        } else {
            node = nil
        }
        return node
    }
    
    func toString() -> String {
       
        var string = ""
        var node = self
        while (node.next != nil) {
            string += "\(node.data)->"
            node = node.next!
        }
        string += "\(node.data)->"
        string += "nil"
        return string
    }
}



// MARK: Question 2.1
extension Node {
    
    /// Remove duplicates nodes using a buffer
    func removeDuplicates() {
        var buffer = [Int:Bool]()
        var node = self
        buffer[node.data] = true
        while (node.next != nil) {
            if buffer[node.next!.data] == true {
                node.next = node.next!.deleteNode()
            } else {
                buffer[node.next!.data] = true
                node = node.next!
            }
        }
    }
    
    /// Remove duplicates nodes without buffer
    func removeDuplicatesWithoutBuffer() {
        var node = self
        while (node.next != nil) {
            
            var runner: Node? = node.next
            while (runner != nil) {
                if node.data == runner?.data {
                    runner = runner?.deleteNode()
                }
                runner = runner?.next
            }
            node = node.next!
        }
    }
}

var head2_1 = Node(data: 10)
head2_1.addToTailWithData(11)
head2_1.addToTailWithData(10)
head2_1.addToTailWithData(12)
println(head2_1.toString())
head2_1.removeDuplicates()
println(head2_1.toString())




// MARK: Question 2.2
extension Node {
    
    func kthToLast(kth:Int) -> Node? {
        var k: Node? = self
        var end: Node? = self
        var count = 0
        while (count < kth-1 && end?.next != nil) {
            end = end?.next!
            count++
        }
        while (end?.next != nil) {
            k = k?.next
            end = end?.next
        }
        return k
    }
    
}

var head2_2 = Node(data: 10)
head2_2.addToTailWithData(11)
head2_2.addToTailWithData(12)
head2_2.addToTailWithData(13)
println(head2_2.toString())
head2_2 = head2_2.kthToLast(2)!
println(head2_2.toString())



// MARK: Question 2.3
extension Node {
    
    func deleteCurrentNode() -> Bool {
        if let next = self.next {
            self.data = next.data
            if next.next != nil {
                self.next = next.next
            }else{
                self.next = nil
            }
            return true
        }else{
            return false
        }
    }
}


var head2_3 = Node(data: 10)
head2_3.addToTailWithData(11)
head2_3.addToTailWithData(12)
head2_3.addToTailWithData(13)
var nodeToDelete = head2_3.next?.next
nodeToDelete?.deleteCurrentNode()
print(head2_3.toString())




// MARK: Question 2.4
extension Node {
    
    func partitionByData(data:Int) -> Node {
        var firstPartition: Node?
        var secondPartition: Node?
        var firstPartitionEnd: Node?
        
        var node: Node? = Node(data: self.data)
        node?.next = self.next
        while ( node != nil ){
            if(node?.data < data){
                if (firstPartition == nil ) {
                    firstPartition = Node(data: node!.data)
                    firstPartitionEnd = firstPartition
                }else{
                    firstPartitionEnd = firstPartition!.addToTailWithData(node!.data)
                }
            }else{
                if (secondPartition == nil) {
                    secondPartition = Node(data: node!.data)
                }else{
                    secondPartition!.addToTailWithData(node!.data)
                }
            }
            
            node = node?.next
        }
        
               
        if firstPartition == nil {
            return secondPartition!
        }
      

        firstPartitionEnd?.next = secondPartition
        
        
        return firstPartition!
    }
    
}

var head2_4 = Node(data: 10)
head2_4.addToTailWithData(14)
head2_4.addToTailWithData(12)
head2_4.addToTailWithData(15)
head2_4.addToTailWithData(6)
head2_4.addToTailWithData(18)
print(head2_4.toString())
print(head2_4.partitionByData(13).toString())

// MARK: Question 2.5_A
extension Node {
    
    class func addLists(node1: Node?, node2: Node?,  carry:Int) -> Node? {
        if(node1 == nil && node2 == nil && carry == 0){
            return nil
        }
        
        var result = Node(data: 0)
        
        var value = carry
        
        if(node1 != nil){
            value += node1!.data
        }
        
        if(node2 != nil){
            value += node2!.data
        }
        
        result.data = value%10
        
        if(node1 != nil || node2 != nil){
            let more = addLists(node1 == nil ? nil : node1!.next,
                node2: node2 == nil ? nil : node2!.next,
                carry: value >= 10 ? 1: 0)
            result.next = more
        }
        
        return result
    }
}


var number1 = Node(data: 2)
number1.addToTailWithData(2)
number1.addToTailWithData(6)
number1.addToTailWithData(7)
print(number1.toString())
var number2 = Node(data: 3)
number2.addToTailWithData(3)
number2.addToTailWithData(4)
number2.addToTailWithData(5)
number2.addToTailWithData(1)
print(number2.toString())
print(Node.addLists(number1, node2: number2, carry: 0)!.toString())


// MARK: Question 2.5_B
extension Node {
    
    class func addLists(node1: Node?, node2: Node?) -> Node? {
        if (node1 == nil){
            return node2
        }
        
        if(node2 == nil){
            return node1
        }
        
        var length1:Int = length(node1)
        var length2:Int = length(node2)
        
        var list1:Node? = node1
        var list2:Node? = node2
        
        if(length1 < length2){
            list1 = padList(node1!, length: length2-length1)
        }
        
        if(length2 < length1){
            list2 = padList(node2!, length: length1-length2)
        }
        
        
        let result = addListsHelper(list1, digit2: list2)
        
        if(result.carry>0){
            var finalResult = Node(data: 0)
            finalResult.data = result.carry
            finalResult.next = result.head
            return finalResult
        }else{
            return result.head
        }
        
    }
    
    
    class func addListsHelper(digit1: Node?, digit2: Node?) -> (head: Node?, carry: Int){
        
        if(digit1 == nil && digit2 == nil){
            return (nil, 0)
        }
        
        var result = addListsHelper(digit1!.next, digit2:digit2!.next)
        
        var sum = result.carry + digit1!.data + digit2!.data
        
        var finalResult = Node(data: 0)
        finalResult.data = sum%10
        finalResult.next = result.head
        
        return (finalResult, sum/10)
        
    }
    
    class func padList(node: Node, length:Int) -> Node {
        var head = node
        for i in 0..<length {
            var zeroHead = Node (data: 0)
            zeroHead.next = head
            head = zeroHead
        }
        return head
    }
    
    class func length (node: Node?) -> Int {
        var lenght = 0
        var currentNode = node
        while(currentNode != nil){
            lenght++
            currentNode = currentNode?.next
        }
        return lenght
    }
}


var list1 = Node(data: 9)
list1.addToTailWithData(5)
list1.addToTailWithData(6)
list1.addToTailWithData(7)
list1.addToTailWithData(7)
print(list1.toString())
var list2 = Node(data: 5)
list2.addToTailWithData(3)
list2.addToTailWithData(4)
list2.addToTailWithData(5)
print(list2.toString())
print(Node.addLists(list1, node2: list2)!.toString())

// MARK Question 2.6
extension Node {
    
    class func findBeginning(head: Node?) -> Node? {
        var slowRunner = head
        var fastRunner = head
        
        while fastRunner != nil  && fastRunner!.next != nil {
            slowRunner = slowRunner!.next
            fastRunner = fastRunner!.next!.next
            
            if slowRunner === fastRunner {
                break
            }
        }
        
        if fastRunner == nil  || fastRunner!.next == nil {
            return nil
        }
        
        slowRunner = head
        while slowRunner !== fastRunner {
            slowRunner = slowRunner!.next
            fastRunner = fastRunner!.next
        }
        
        return slowRunner
    }
}


//1->2->3->4->5->6->3
var loop = Node(data: 1)
loop.addToTailWithData(2)
loop.addToTailWithData(3)
var loopHead = loop.addToTailWithData(3)
loop.addToTailWithData(4)
loop.addToTailWithData(5)
var loopEnd = loop.addToTailWithData(6)
loopEnd.next = loopHead
Node.findBeginning(loop)


