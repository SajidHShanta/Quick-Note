//
//  LoaderExtension.swift
//  QuickNote
//
//  Created by Sajid Shanta on 9/7/23.
//

import UIKit

extension UIViewController {

    func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5 , width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = .large
        alert.view.addSubview(indicator)
        self.present(alert, animated: true)
        return alert
    }
    
    func stopLoader(loader: UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true)
        }
    }
    
    func setupLoader(forSec: Int = 1) {
        let loader = self.loader()
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(forSec)) {
            self.stopLoader(loader: loader)
        }
    }
}
