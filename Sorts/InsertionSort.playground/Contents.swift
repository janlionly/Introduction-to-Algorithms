import Foundation

struct Sorts {
    func insertionSort(array: [Int]) -> [Int] {
        var A = array
        for j in 1..<array.count {
            let key = array[j]
            var i = j - 1
            
            // move forward to find target index to insert
            while i >= 0 && A[i] > key {
                A[i + 1] = A[i]
                i = i - 1
            }
            A[i + 1] = key
        }
        return A
    }
}

var A = [16, 12, 7, 9, 11, 0, 9, 7, 3, 17]

let sorter = Sorts()
print(sorter.insertionSort(array: A))



