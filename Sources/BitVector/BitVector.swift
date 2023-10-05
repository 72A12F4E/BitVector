import Foundation

typealias StorageType = UInt

public struct BitVector: RandomAccessCollection {
    private var storage: [StorageType] = []
    
    public private(set) var count: Int = 0
    
    public var startIndex: Int { 0 }
    
    public var endIndex: Int { count }
    
    public mutating func append(_ value: Bool) {
        let storageCount = storage.count
        if count < storageCount * StorageType.bitWidth {
            let mask: UInt = 1 << (count % StorageType.bitWidth)
            if value {
                storage[storageCount - 1] |= mask
            } else {
                storage[storageCount - 1] &= ~mask
            }
        } else {
            storage.append(UInt(value ? 1 : 0))
        }
        count += 1
    }
    
    public subscript(index: Int) -> Bool {
        get {
            precondition((0..<count).contains(index), "Index \(index) out of range")
            return storage[index / StorageType.bitWidth] & (1 << (index % StorageType.bitWidth)) != 0
        }
        set(newValue) {
            precondition((0..<count).contains(index), "Index \(index) out of range")
            let mask: UInt = 1 << (index % StorageType.bitWidth)
            if newValue {
                storage[index / StorageType.bitWidth] |= mask
            } else {
                storage[index / StorageType.bitWidth] &= ~mask
            }
        }
    }
}

extension BitVector: CustomStringConvertible {
    public var description: String {
        var desc = ""
        for element in self {
            desc.append(element ? "1" : "0")
        }
        return "[" + desc + "]"
    }
}
