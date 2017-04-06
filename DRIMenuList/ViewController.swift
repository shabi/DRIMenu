//
//  ViewController.swift
//  DRIMenuList
//
//  Created by Shabi Haider Naqvi on 05/04/17.
//  Copyright © 2017 Shabi Haider Naqvi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var parsedComplexArray: [DRIComplexOption]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    DRIComplexOption.parseComplexObject { (complexObjArray, status) in
      self.parsedComplexArray = complexObjArray
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

