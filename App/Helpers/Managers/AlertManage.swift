//
//  UtilManage.swift
//  Translate
//
//  Created by Trần An on 4/29/18.
//  Copyright © 2018 AnTran. All rights reserved.
//


import UIKit
import SystemConfiguration

public enum BAlertType: Int {
    case ok = 0
    case yesNo
    case cancel
    case deleteCancel
}

public enum BButtonResult: Int {
    case ok = 0
    case yes
    case no
    case cancel
    case delete
}

private enum ActionTitle: String {
    case ok = "OK"
    case yes = "Yes"
    case no = "No"
    case cancel = "Cancel"
    case delete = "Delete"
}


typealias alertTapHandler = (_ alertView: UIAlertController, _ button: BButtonResult) -> ()
typealias actionSheetTapHandler = (_ titleSelected: String, _ button: BButtonResult?) -> ()

class UtilManage: NSObject {
    class func showAlert(message: String, type: BAlertType, complete: alertTapHandler?) {
        showAlert(title: "", message: message, type: type, complete: complete)
    }
    class func showAlert(title: String, message: String, type: BAlertType, complete: alertTapHandler?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        switch type {
        case .ok:
            let ok = UIAlertAction(title: ActionTitle.ok.rawValue, style: .destructive, handler: { (alertAction) in
                if let complete = complete {
                    complete(alert, .ok)
                }
            })
            alert.addAction(ok)
            
        case .yesNo:
            let yes = UIAlertAction(title: ActionTitle.yes.rawValue, style: .default, handler: { (alertAction) in
                if let complete = complete {
                    complete(alert, .yes)
                }
            })
            
            let no = UIAlertAction(title: ActionTitle.no.rawValue, style: .default, handler: { (alertAction) in
                if let complete = complete {
                    complete(alert, .no)
                }
            })
            
            alert.addAction(no)
            alert.addAction(yes)
            
        case .deleteCancel:
            let delete = UIAlertAction(title: ActionTitle.delete.rawValue.uppercased(), style: .default, handler: { (alertAction) in
                if let complete = complete {
                    complete(alert, .delete)
                }
            })
            
            let cancel = UIAlertAction(title: ActionTitle.cancel.rawValue.uppercased(), style: .default, handler: { (alertAction) in
                if let complete = complete {
                    complete(alert, .cancel)
                }
            })
            
            alert.addAction(cancel)
            alert.addAction(delete)
            
        case .cancel:
            let cancel = UIAlertAction(title: ActionTitle.cancel.rawValue, style: .destructive, handler: { (alertAction) in
                if let complete = complete {
                    complete(alert, .cancel)
                }
            })
            alert.addAction(cancel)
        }
        
        UIApplication.getTopViewController()!.present(alert, animated: true, completion: nil)
    }
    

    // MARK: alert
    class func alert(message: String, type: BAlertType, complete: alertTapHandler?) {
        alert(title: "", message: message, type: type, complete: complete)
    }
    
    class func alert(title: String, message: String, type: BAlertType, complete: alertTapHandler?) {
        DispatchQueue.main.async {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        switch type {
        case .ok:
            let ok = UIAlertAction(title: ActionTitle.ok.rawValue, style: .destructive, handler: { (alertAction) in
                if let complete = complete {
                    complete(alert, .ok)
                }
            })
            alert.addAction(ok)
            
        case .yesNo:
            let yes = UIAlertAction(title: ActionTitle.yes.rawValue, style: .destructive, handler: { (alertAction) in
                if let complete = complete {
                    complete(alert, .yes)
                }
            })
            
            let no = UIAlertAction(title: ActionTitle.no.rawValue, style: .default, handler: { (alertAction) in
                if let complete = complete {
                    complete(alert, .no)
                }
            })
            
            alert.addAction(yes)
            alert.addAction(no)
            
        case .cancel:
            let cancel = UIAlertAction(title: ActionTitle.cancel.rawValue, style: .destructive, handler: { (alertAction) in
                if let complete = complete {
                    complete(alert, .cancel)
                }
            })
            alert.addAction(cancel)
        case .deleteCancel:
            let delete = UIAlertAction(title: ActionTitle.delete.rawValue.uppercased(), style: .destructive, handler: { (alertAction) in
                if let complete = complete {
                    complete(alert, .delete)
                }
            })
            
            let cancel = UIAlertAction(title: ActionTitle.cancel.rawValue.uppercased(), style: .default, handler: { (alertAction) in
                if let complete = complete {
                    complete(alert, .cancel)
                }
            })
            
            alert.addAction(cancel)
            alert.addAction(delete)
        }
        
            UIApplication.getTopViewController()!.present(alert, animated: true, completion: nil)
    }
}
    class func share(text: String, sourceView:UIView?, viewcontroller:UIViewController) {
        let activity = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        if activity.popoverPresentationController != nil {
            activity.popoverPresentationController?.sourceView = sourceView
        }
        
        viewcontroller.present(activity, animated: true, completion: nil)
    }
    // MARK: actionsheet
    // MARK: actionsheet
    class func actionSheet(buttons: [String], complete: actionSheetTapHandler?) {
        actionSheet(title: "", buttons: buttons, complete: complete)
    }
    
    class func actionSheet(title: String, buttons: [String], complete: actionSheetTapHandler?) {
        let actionSHEET = UIAlertController(title: title, message: "", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: ActionTitle.cancel.rawValue, style: .cancel) {
            (result : UIAlertAction) -> Void in
            if let complete = complete {
                complete(result.title!, BButtonResult.cancel)
            }
        }
        actionSHEET.addAction(cancelAction)
        
        for item in buttons {
            let action = UIAlertAction(title: item, style: .default, handler: { (result) in
                if let complete = complete {
                    complete(result.title!, nil)
                }
            })
            actionSHEET.addAction(action)
        }
        
        UIApplication.getTopViewController()!.present(actionSHEET, animated: true, completion: nil)
    }

    
    class func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let result = (isReachable && !needsConnection)
        
        return result
    }
    
}
