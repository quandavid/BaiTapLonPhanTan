//
//  ViewControllerDelegate.swift
//  Nekopost
//
//  Created by An Nguyen on 5/24/16.
//  Copyright © 2016 Sota Tek. All rights reserved.
//

import Foundation
import UIKit

@objc protocol ViewControllerDelegate {
    @objc optional func viewControllerDidDismiss(sender: UIViewController, data: [String: AnyObject])
}
