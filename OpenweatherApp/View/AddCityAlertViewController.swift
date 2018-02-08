//
//  AddCityAlertViewController.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 09.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import UIKit

class AddCityAlertViewController: UIAlertController {
    
    var presenter: MainPresenterProtocol!
    
    static func create(with presenter: MainPresenterProtocol) -> AddCityAlertViewController {
        let alert = AddCityAlertViewController (title: "Add city", message: nil, preferredStyle: .alert)
        alert.presenter = presenter
        
        alert.addTextField { (textField) in
            textField.placeholder = "City name"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) {(_) in
            alert.presenter.enteredCityToAdd()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {(_) in
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        return alert
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        addTextField { (textField) in
//            textField.placeholder = "City name"
//        }
//
//        let addAction = UIAlertAction(title: "Add", style: .default) {(_) in
//            self.presenter.enteredCityToAdd()
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {(_) in
//        }
//
//        self.addAction(addAction)
//        self.addAction(cancelAction)
    }
    
    func enteredCity() -> String? {
        return self.textFields?.first?.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
