@testable import Drawing
import Hope
import Peek

import Foundation

class GeneticTests: XCTestCase {
    
    func test_json() throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(CGCircle(center: .unit, radius: 5))
        String(data: data, encoding: .utf8).peek("✅")
    }
    
    func test_plist() throws {
        struct A: Codable {
            
            var string: String = "string in A"
            var int: Int = 11
            var b: B = B()
            
            struct B: Codable {
                var string: String = "string in B"
                var int: Int = 22
            }
        }
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        let data = try encoder.encode(A())
        String(data: data, encoding: .ascii).peek("✅")
        
        let decoder = PropertyListDecoder()
        _ = try decoder.decode(A.self, from: data) ¶ "✅".here()
    }
}

/*
 
 TOP LEVEL [VALUE:TYPE] SHOULD BE ENOUGH!
 
 {
    "type": "CGRect",
    "value": [0, 1, 2, 3]
 }
 */

// consider AnyType!

//struct CopyPaste: Codable {
//    var types = [
//        CGSize?,
//        CGCircle?,
//        CGEllipse?
//    ]
//}
