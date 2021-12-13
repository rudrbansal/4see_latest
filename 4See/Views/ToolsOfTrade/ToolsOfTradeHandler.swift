//
//  ToolsOfTradeHandler.swift
//  4See
//
//  Created by apple on 11/12/21.
//

import Foundation

class ToolsOfTradeHandler {
    static let `default` = toolsTradeHandler()
    var id = ""   //id
    var title = ""  //title
    var serialNumber = ""   //serial Number
    var imageData = [Data]() //imageData

}

extension ToolsOfTradeHandler {
    
    /// Create JSON Object
    func addSystemObjectJSON() -> [String: AnyObject] {
        let dictionary: [String: Any] = ["id": id,
                                         "title": title,
                                         "serialNumber":serialNumber]
        return dictionary as [String : AnyObject]
    }
   
}
