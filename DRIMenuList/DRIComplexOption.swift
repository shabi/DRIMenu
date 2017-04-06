//
//  DRIComplexOption.swift
//  DRIMenuList
//
//  Created by Shabi Haider Naqvi on 05/04/17.
//  Copyright © 2017 Shabi Haider Naqvi. All rights reserved.
//

import UIKit

class DRIComplexOption: DRIOption {
  var renderingOption: String?
  var isMandatory: Bool = false
  var subOptions:[DRIComplexOption]?
  var moreOptions:[DRIComplexOption]?
}


extension DRIComplexOption {

  static func iterateOptionsRecurrcive(complexObj: [String: Any]) -> DRIComplexOption {
    
    let complexParsedObj = DRIComplexOption()
    
    complexParsedObj.name = complexObj["name"] as! String!
    complexParsedObj.optionDescription = complexObj["description"] as! String!
    complexParsedObj.optionId = complexObj["optionId"] as! String!
    
    if let price = complexObj["price"] as? UInt {
      complexParsedObj.price = price
    }
    
    if let renderingOption = complexObj["renderingOption"] as? String {
      complexParsedObj.renderingOption = renderingOption
    }
    
    if let selectedId = complexObj["selectedId"] as? String {
      complexParsedObj.selectedId = selectedId
    }
    if let optionType = complexObj["optionType"] as? String {
      complexParsedObj.optionType = optionType
    }
    
    if let greyOut = complexObj["greyOut"] as? Bool {
      complexParsedObj.greyOut = greyOut
    }
    if let isMandatory = complexObj["isMandatory"] as? Bool {
      complexParsedObj.isMandatory = isMandatory
    }
    
    if let optionName = complexObj["optionName"] as? String {
      complexParsedObj.optionName = optionName
    }
    
    if let moreOptions = complexObj["moreOptions"] as? Array<[String: Any]> {
      
      complexParsedObj.moreOptions = moreOptions.map({ (dict) -> DRIComplexOption in
        
        return self.iterateOptionsRecurrcive(complexObj: dict)
      })
    }
    
    if let subOptionsArray = complexObj["options"] as? Array<[String: Any]> {
      
      complexParsedObj.subOptions = subOptionsArray.map({ (dict) -> DRIComplexOption in
        
        return self.iterateOptionsRecurrcive(complexObj: dict)
      })
    }
    
    return complexParsedObj
  }
  
  static func parseComplexObject(completionHandler: @escaping (( _ complexObjArray: [DRIComplexOption]?, _ success: Bool) -> Void)) {
    
    let urlRequest = URLRequest(url: URL(string: "http://demo0327138.mockable.io/")!)
    
    //setup the session
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    //make request
    let complexTask = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
      
      do {
        
        guard let directionDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] else {
          print("error trying to convert data to JSON")
          return
        }
        
        let complexObjDicArray = directionDictionary["complexOptions"] as! Array<[String: Any]>
        
        var complexObjArray = [DRIComplexOption]()
        for complexObj in complexObjDicArray {
          let x = self.iterateOptionsRecurrcive(complexObj: complexObj)
          complexObjArray.append(x)
        }
        //Fire success completion handler
        completionHandler(complexObjArray, true)
        
      } catch  {
        print("error trying to convert data to JSON")
        return
      }
    }
    complexTask.resume()
  }
  


}
