//
//  ViewExtension.swift
//  One BPM
//
//  Created by Brian Diaz Alvarez on 18/03/2020.
//  Copyright © 2020 Brian Diaz Alvarez. All rights reserved.
//

import UIKit

extension UIView{
    func animShow(){
        self.center.y += self.bounds.height
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()

        },  completion: {(_ completed: Bool) -> Void in
        self.isHidden = true
            })
    }
}
