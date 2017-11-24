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
        // self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        let earthParent = SCNNode() // these nodes will allow us to rotate earth and venus around the sun at different speeds (my idea!)
        let venusParent = SCNNode()
        let moonParent = SCNNode()
        
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun diffuse")
        
        sun.position = SCNVector3(0, 0, -1)
        earthParent.position = SCNVector3(0, 0, -1)
        venusParent.position = SCNVector3(0, 0, -1)
        moonParent.position = SCNVector3(1.2, 0, 0)
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth specular"), emission: #imageLiteral(resourceName: "Earth emission"), normal: #imageLiteral(resourceName: "Earth normal"), position: SCNVector3(1.2, 0, 0))
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus diffuse"), specular: nil, emission: #imageLiteral(resourceName: "Venus emission"), normal: nil, position: SCNVector3(0.7, 0, 0))
        let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "Moon diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -0.3))
        
        let sunAction = rotation(time: 24)
        let earthParentRotation = rotation(time: 40)
        let venusParentRotation = rotation(time: 32)
        let earthRotation = rotation(time: 24)
        let moonRotation = rotation(time: 12)
        let venusRotation = rotation(time: 24)
        
        sun.runAction(sunAction)
        
        earth.runAction(earthRotation)
        venus.runAction(venusRotation)
        earthParent.runAction(earthParentRotation)
        venusParent.runAction(venusParentRotation)
        moonParent.runAction(moonRotation)
        
        earthParent.addChildNode(earth)
        earthParent.addChildNode(moonParent) // which is in the exact same place as the earth
        venusParent.addChildNode(venus)
        moonParent.addChildNode(moon)
    }
    
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }
    
    func rotation(time: TimeInterval) -> SCNAction {
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(rotation)
        return foreverRotation
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension Int {
    var degreesToRadians: Double {return Double(self) * .pi/180}
}
