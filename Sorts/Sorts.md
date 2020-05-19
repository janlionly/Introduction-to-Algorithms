

# Sorts(从小到大)

## 1. Insertion-Sort

插入排序: 将包含n个元素的输入序列分成左右两切片, 左切片A[0...j-1]是已排序的, 右切片A[j...n]未排序,算法思路是从右切片逐个取数通过对比插入到左切片相应的位置.

### 分解

```instruction
1. 从未排序的切片中依次取数;
2. 取出的数通过对比插入到左切片相应的位置.
```

- 将此数key从原序列位置拿出放入临时位置上, 已排序末端到起端位置[j-1...0], 如果key比i位置上的X要大, 则把X往前移到i+1位置上,以此类推, 直到到达起端位置前A[i]比key小时停止移动. 

- 演示图: (数字类比为带ID的学生, 位置类比为座位, 一排坐着学生的座位, key为待安排入的学生)

    key = 9

  - [1, 2, 5, 7, 10, **11**, 9, ...] , 下标i = 5, X = 11
  - [1, 2, 5, 7, 10, ~~11~~, **11**, ...], X = 11, 比key大, 11往前移一位
  - [1, 2, 5, 7, ~~10~~, **10**, 11, ...], 下标i = 4, X = 10, 比key大, 10往前移一位
  - [1, 2, 5, 7, ~~10~~, 10, 11, ...], 下标i = 3, X = 7, 比key小, 停止移动
  - [1, 2, 5, 7, key, 10, 11, ...], 此时把key放入数据往前移动后腾出的空位(对应下标为i + 1)

```swift
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
```

### 时间复杂度

从分解步骤中, 第一步从未排序的数中逐个取数需要n步, 取出每一个数进行移动插入最多需要n步, 所以总共需要 n * n步, 时间复杂度为O(n^2).

## 2. Merge-Sort

归并排序: 将待排序的n个元素序列分成n/2个元素的两个子序列, 将n/2个元素的序列再分成n/4个元素的两个子序列, 依次类推直到只包含1个元素的子序列后,对子序列合并,然后递归回升归并两个已排好序的子序列.

### 分解

```instruction
1. 递归地将一个待排序的序列对半拆分成两个待排序的子序列, 直到子序列长度为1为止;
2. 将两个已排好序的子序列进行合并.
```

- __将两个已排序的子序列进行合并__: 设A[p...q]和A[q+1...r]都已排好序,序列里的数字比为牌, 现准备两个装牌的凹槽和一个带有下标编码容纳所有牌的横槽.把A[p...q]中的牌放入左凹槽, 将A[q+1...r]的牌放入右凹槽, 将两凹槽最上面的牌进行比较, 每次拿出较小者按下标编码(p...r)顺序放入横槽, 这样进行(r-p+1)次这种操作即可将两个排好序的子序列排序成一个序列.(在进行此操作时必有一个凹槽会先出现无牌,为了方便重复上面的比较操作,在每个凹槽最底部增加一张牌面最大的牌Gt(Gost).

- 演示图
  | _ _ _ _ _ _  | 3 _ _ _ _ _ | 3 4 _ _ _ _ | 3 4 5 _ _ _ | 3 4 5 7 _ _ | 3 4 5 7 J _ | 3 4 5 7 J K |
  | :---------: | :---------: | :---------: | :---------: | :---------: | :---------: | :---------: |
  | 3&#8195;&#8195;5 | _&#8195;&#8195;5 | _&#8195;&#8195;5 | _&#8195;&#8195;_ | _&#8195;&#8195;_ | _&#8195;&#8195;_ | _&#8195;&#8195;_ |
  | 4&#8195;&#8195;J | 4&#8195;&#8195;J | _&#8195;&#8195;J | _&#8195;&#8195;J | _&#8195;&#8195;J | _&#8195;&#8195;_ | _&#8195;&#8195;_ |
  | 7&#8195;&#8195;K | 7&#8195;&#8195;K | 7&#8195;&#8195;K | 7&#8195;&#8195;K | _&#8195;&#8195;K | _&#8195;&#8195;K | _&#8195;&#8195;_ |
  | Gt&#8195;&#8195;Gt | Gt&#8195;&#8195;Gt | Gt&#8195;&#8195;Gt | Gt&#8195;&#8195;Gt | Gt&#8195;&#8195;Gt | Gt&#8195;&#8195;Gt | Gt&#8195;&#8195;Gt |

```swift
  func merge(_ array: inout [Int], _ leftIndex: Int, _ midIndex: Int, _ rightIndex: Int) {
    let max = Int.max
    var lefts = Array(array[leftIndex...midIndex])
    lefts.append(max)
    var rights = Array(array[midIndex + 1...rightIndex])
    rights.append(max)
    
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
  }
```

__递归地将一个待排序的序列对半拆分成两个待排序的子序列, 直到子序列长度为1为止__:

```swift
  func mergeSort(_ array: inout [Int], leftIndex: Int, rightIndex: Int) {
    if leftIndex == rightIndex { // 当序列长度为1时无法再拆分,返回
      return
    }
    let midIndex = (rightIndex + leftIndex)/2
    mergeSort(&array, leftIndex: leftIndex, rightIndex: midIndex)
    mergeSort(&array, leftIndex: midIndex + 1, rightIndex: rightIndex)
    merge(&array, leftIndex, midIndex, rightIndex)
  }
```

### 时间复杂度

设T(n)为算法需要执行的总步数, 归并拆分为两个规模为n/2的步数和一个merge操作所需步数, 可以看出merge操作的是关于n的for循环,for循环体内的操作与n无关,为O(1),故merge操作为O(n), 所以有以下递归式:

T(n) = 2*T(n/2) + O(n)

T(1) = O(1)

用此递归式可以构建出一棵lgn层的树(规模为n每次拆为均分的两段, 最多执行lgn次可以拆分为长度为1的两段), 此树每层的复杂度为cn,故总的复杂度为T(n) = lgn * cn = O(n*lgn)


## 3. Bubble-Sort

冒泡排序：重复地走访要排序的元素列，依次比较相邻的元素执行交换，一趟下来就可以筛选出最小值，对剩余的元素列重新执行以上步骤，直到筛选完全部。

### 分解

```instruction
1. 对元素列从尾到头开始，依次比较相邻元素，每次将右边较小者和左边较大者进行交换位置；
2. 除开最左边已经筛选出的元素，对剩下的元素列重复步骤1的操作。
```

- 演示图
  
  - 5，2，10，9，6，3，7
  - 5，2，10，9，***3***，***6***，7
  - 5，2，10，***3***，***9***，6，7
  - 5，2，***3***，***10***，9，6，7
  - ***2***，***5***，3，10，9，6，7
  - 2（5，3，10，9，6，7）对括号内的元素列重复以上步骤。

```swift
func bubbleSort(_ array: inout [Int]) {
  for i in 0..<array.count-1 { // n个元素，进行n-1趟的筛选比较可以完成
    for j in (i+1..<array.count).revesed() {
      if array[j-1]>array[j] {
        (array[j-1], array[j]) = (array[j], array[j-1])
      }
    }
  } 
}
```



## 4. Quick-Sort

快速排序：将一个序列A[p...r]拆分成两个子序列（可能为空）A[p...q-1]和A[q+1...r]，使得A[p...q-1]的元素都小于等于A[q], A[q+1...r]的元素都大于等于A[q], 对A[p...q-1]和A[q+1...r]执行以上同样的操作。

### 分解

```instruction
1. 将一个序列A[p...r]拆分成两个子序列（可能为空）A[p...q-1]和A[q+1...r]，使得A[p...q-1]的元素都小于等于A[q], A[q+1...r]的元素都大于等于A[q];
2. A[p...q-1]和A[q+1...r]执行以上步骤1同样的操作；
```

步骤1：【V1版本】选择A[r]作为要比较的中间元素key，遍历A[p...***r-1***]的每个元素，将小于等于key的元素放入数组L，将大于key的元素放入数组R，然后遍历数组L(k1)的元素，将其放入A[p...x], 将key插入A[x+1], 将R(k2)的元素放入A[x+2...r], 此时对于的key下标q即为x+1.
```swift
func partition(_ array: inout [Int], p: Int, r: Int) -> Int {
  let key = A[r]
  var L: [Int] = []
  var R: [Int] = []
  var targetIndex = 0
  
  for i in (p...r-1) { // A[r]已经拿出来做key，故下标取到r-1
    if A[i] <= key {
      L.append(A[i])
    } else {
      R.append(A[i])
    }
  }
  
  var lindex = p
  for i in 0..<L.count {
    array[lindex] = L[i]
    lindex += 1
  }
  array[lindex] = key
  targetIndex = lindex
  
  var rindex = lindex + 1
  for i in 0..<R.count {
    array[rindex] = R[i]
    rindex += 1
  }
  
  return targetIndex
}
```

步骤2： A[p...q-1]和A[q+1...r]执行以上步骤1同样的操作.

```swift
func quickSort(_ array: inout [Int], p: Int, r: Int) {
  if lowIndex >= highIndex {
    return
  }
  int q = partition(array, p, r)
  quickSort(array, p, q-1)
  quickSort(array, q+1, r)
}
```

### 时间复杂度

设T(n)为快速排序的总步骤，其中paritition的时间复杂度是O(n), 最坏情况下将序列拆分为两个子序列，长度分别是n-1和0，则：T(n) = T(n-1) + T(0) + O(n), 每一层被拆分为n-1步，需要拆分n次，故最坏情况时间复杂度为O(n^2), 最好情况下，序列被拆分为不大于n/2的两个子序列，此时T(n) = 2*T(n/2) + O(n), 则时间复杂度为O(nlgn).





​    

  

