//
//  main.swift
//  Sorts
//
//  Created by janlionly<jan_ron@qq.com> on 2020/5/13.
//  Copyright © 2020 Janlionly. All rights reserved.
//

import Foundation

struct Sorts {
    // 1. 插入排序
    func insertionSort(array: inout [Int]) {
        for j in 1..<array.count {
            let key = array[j]
            var i = j - 1
            
            // move forward to find target index to insert
            while i >= 0 && array[i] > key {
                array[i + 1] = array[i]
                i = i - 1
            }
            array[i + 1] = key
        }
    }
    
    // 2. 归并排序
    func mergeSort(array: inout [Int]) {
        mergeSort(&array, leftIndex: 0, rightIndex: array.count - 1)
    }
    
    private func mergeSort(_ array: inout [Int], leftIndex: Int, rightIndex: Int) {
        if leftIndex >= rightIndex {
            return
        }
        let midIndex = (rightIndex + leftIndex)/2
        mergeSort(&array, leftIndex: leftIndex, rightIndex: midIndex)
        mergeSort(&array, leftIndex: midIndex + 1, rightIndex: rightIndex)
        merge(&array, leftIndex, midIndex, rightIndex)
    }
    
    private func merge(_ array: inout [Int], _ leftIndex: Int, _ midIndex: Int, _ rightIndex: Int) {
        let max = Int.max
        var lefts = Array(array[leftIndex...midIndex])
        lefts.append(max)
        var rights = Array(array[midIndex + 1...rightIndex])
        rights.append(max)
        
//        print("Index(left:\(leftIndex),mid:\(midIndex),right:\(rightIndex)) Arr:\(array)")
//        print("leftArr:\(array[leftIndex...midIndex]), rightArr:\(array[midIndex+1...rightIndex])")
        
        var i = 0
        var j = 0
        for t in leftIndex...rightIndex {
            if lefts[i] < rights[j] {
                array[t] = lefts[i]
                i = i + 1
            } else {
                array[t] = rights[j]
                j = j + 1
            }
        }
        
//        print("After merge arr:\(array[leftIndex...rightIndex])\n")
    }
    
    // 3. 冒泡排序
    func bubbleSort(array: inout [Int]) {
        for i in 0..<array.count - 1 {
            for j in (i+1..<array.count).reversed() {
                if array[j-1] > array[j] {
                    (array[j-1], array[j]) = (array[j], array[j-1])
                }
            }
        }
    }
    
    // 4. 快速排序
    func quickSort(array: inout [Int]) {
        quickSort(array: &array, 0, array.count - 1)
    }
    
    private func quickSort(array: inout [Int], _ leftIndex: Int, _ rightIndex: Int) {
        if leftIndex >= rightIndex {
            return
        }
//        let midIndex = partition(array: &array, leftIndex, rightIndex)
        let midIndex = randomPartition(array: &array, leftIndex, rightIndex)
        quickSort(array: &array, leftIndex, midIndex - 1)
        quickSort(array: &array, midIndex + 1, rightIndex)
    }
    
    private func randomPartition(array: inout [Int], _ leftIndex: Int, _ rightIndex: Int) -> Int {
        let i = Int.random(in: leftIndex...rightIndex)
        (array[i], array[rightIndex]) = (array[rightIndex], array[i])
        return partition(array: &array, leftIndex, rightIndex)
    }
    
    private func partition(array: inout [Int], _ leftIndex: Int, _ rightIndex: Int) -> Int {
        var lefts: [Int] = []
        var rights: [Int] = []
        let key = array[rightIndex]
        var midIndex = 0
        
        //print("Index(left:\(leftIndex),right:\(rightIndex)) Arr:\(array)")
        //print("Before array:\(array[leftIndex...rightIndex]), key:\(key)")
        
        for t in leftIndex...rightIndex-1 {
            let item = array[t]
            if item < key {
                lefts.append(item)
            } else {
                rights.append(item)
            }
        }
        
        var currentIndex = leftIndex
        
        for item in lefts {
            array[currentIndex] = item
            currentIndex += 1
        }
        
        midIndex = currentIndex
        array[currentIndex] = key
        currentIndex += 1
        
        for item in rights {
            array[currentIndex] = item
            currentIndex += 1
        }

        //print("After array:\(array[leftIndex...rightIndex]), key:\(key), midIdex:\(midIndex)\n")
        return midIndex
    }
}


// Main
let count = 3000
var A: [Int] = [Int](repeating: 0, count: count)

print("Init array(\(count))")
for i in 0..<count {
    A[i] = Int.random(in: 0...count * 100)
}

print("Starting sorting...")
let sorter = Sorts()
var startTime = Date()
//sorter.insertionSort(array: &A)
sorter.mergeSort(array: &A)
//sorter.bubbleSort(array: &A)
//sorter.quickSort(array: &A)
var endTime = Date()

print("Process seconds:\(endTime.timeIntervalSince(startTime))")


//print("Starting sorting...")
//startTime = Date()
//sorter.quickSort(array: &A)
//endTime = Date()
//print("2Process seconds:\(endTime.timeIntervalSince(startTime))")


print("Sort result:\(A)")

