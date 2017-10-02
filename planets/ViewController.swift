//
//  ViewController.swift
//  planets
//
//  Created by Kenrick Guie on 10/2/17.
//  Copyright © 2017 Kenrick Guie. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let earth = SCNNode()
        earth.geometry = SCNSphere(radius: 0.3)
        earth.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Earth day")
        earth.position = SCNVector3(0,0, -1)
        self.sceneView.scene.rootNode.addChildNode(earth)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

