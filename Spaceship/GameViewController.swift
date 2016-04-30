//
//  GameViewController.swift
//  Spaceship
//
//  Created by Ricardo Rauber on 9/10/14.
//  Copyright (c) 2014 BEPiD POA. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    func createScene() {
        
        // Load file
        let scene = GameScene(fileNamed:"GameScene")
        
        // Configure the view.
        let skView = self.view as! SKView
//        skView.showsFPS = true
//        skView.showsNodeCount = true
//        skView.showsDrawCount = true
//        skView.showsFields = true
//        skView.showsPhysics = true
//        skView.showsQuadCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene!.scaleMode = .AspectFill
        
        // Present Scene with Fade
        skView.presentScene(scene!, transition: SKTransition.fadeWithDuration(0.5))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.createScene), name: "loadScene", object: nil)
        self.createScene()
    }
}
