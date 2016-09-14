//
//  ViewController.swift
//  MKGradientViewExample
//
//  Created by Max Konovalov on 19/10/15.
//  Copyright © 2015 Max Konovalov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var linearGradientView: MKGradientView!
    @IBOutlet weak var radialGradientView: MKGradientView!
    @IBOutlet weak var conicalGradientView: MKGradientView!
    @IBOutlet weak var bilinearGradientView: MKGradientView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var colors = [UIColor]()
        let n = 9
        for i in 0..<n {
            let color = UIColor(hue: CGFloat(i)/CGFloat(n), saturation: 1.0, brightness: 1.0, alpha: 1.0)
            colors.append(color)
        }
        
        
        /*** Linear gradient ***/
        
        linearGradientView.type = .linear
        linearGradientView.colors = colors
        linearGradientView.startPoint = CGPoint(x: 0.0, y: 0.5)
        linearGradientView.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        
        /*** Radial gradient ***/
        
        radialGradientView.type = .radial
        radialGradientView.colors = colors
        
        
        /*** Conical gradient ***/
        
        conicalGradientView.type = .conical
        
        // For smooth-looking conical gradient first and last colors should be the same
        colors.append(colors[0])
        conicalGradientView.colors = colors
        
        
        /*** Bilinear gradient ***/
        
        bilinearGradientView.type = .bilinear
        bilinearGradientView.colors = Array(colors.prefix(colors.count/2))
        bilinearGradientView.colors2 = Array(colors.suffix(colors.count/2)).reversed()
        
    }

}
