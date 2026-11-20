//
//  VC+NavVC.swift
//  GenerateRealmDB
//
//  Created by Дмитро on 19.11.2026.
//

import UIKit


class BaseVC: UIViewController {
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = false
    }
}

class BaseNC: UINavigationController {
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = false
    }
}

