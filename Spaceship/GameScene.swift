//
//  GameScene.swift
//  Spaceship
//
//  Created by Ricardo Rauber on 9/10/14.
//  Copyright (c) 2014 BEPiD POA. All rights reserved.
//

import SpriteKit

class GameScene: SKScene , SKPhysicsContactDelegate
 {
    
    // MARK: Actors
    var title: SKLabelNode!
    var score: SKLabelNode!
    var player: SKSpriteNode!
    var obstacle: SKSpriteNode!
    
    // MARK: Control
    var yObstacle: CGFloat!
    var points: Int = 0
    
    var gameState = stateControl.Title
    var playerPosition = positionInScreen.Center
    var collided = false
    
    // MARK: VC Lifecycle
    override func didMoveToView(view: SKView) {
        
        // Find actors
        for child in self.children
        {
            if child.name == "title"
            {
                self.title = child as SKLabelNode
            }
            else if child.name == "score"
            {
                self.score = child as SKLabelNode
                self.score.alpha = 0
            }
            else if child.name == "player"
            {
                self.player = child as SKSpriteNode
                self.player.alpha = 0
            }
            else if child.name == "obstacle"
            {
                self.obstacle = child as SKSpriteNode
                self.obstacle.alpha = 0
                yObstacle = self.obstacle.position.y
            }
        }
        
        // Physics
        physicsWorld.gravity = CGVectorMake(0,0)
        physicsWorld.contactDelegate = self
        self.player.physicsBody?.categoryBitMask = heroCategory
        self.player.physicsBody?.collisionBitMask = heroCategory
        self.player.physicsBody?.contactTestBitMask = obstacleCategory
        self.player.physicsBody?.usesPreciseCollisionDetection = true
        self.obstacle.physicsBody?.categoryBitMask = obstacleCategory
        self.obstacle.physicsBody?.collisionBitMask = obstacleCategory
    
    }
    
    // MARK: Game Control
    func obstacleControl(firstTime: Bool) {
        if gameState == stateControl.Run {
            
            // Points
            if !firstTime {
                self.points++
                self.score.text = "\(self.points)"
            }
            
            // Change Lane
            let lane = arc4random_uniform(3)
            switch (lane) {
            case 0:
                self.obstacle.position.x = laneLeft
                break
            case 1:
                self.obstacle.position.x = laneCenter
                break
            case 2:
                self.obstacle.position.x = laneRight
                break
            default:
                break
            }
            self.obstacle.position.y = yObstacle
            
            // Move
            self.obstacle.runAction(moveDown, completion: { () -> Void in
                
                // Restart Action
                self.obstacleControl(false)
            })
        }
    }
    
    // MARK: Gestures
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        // Get touch
        let touch = touches.anyObject() as UITouch
        let touchPosition = touch.locationInNode(self)
        
        // Test State
        if gameState == stateControl.Run {
            
            // Change Position
            if touchPosition.x > WIDTH / 2 {
                switch (playerPosition) {
                case .Left:
                    playerPosition = .Center
                    player.runAction(goCenter)
                    break
                case .Center:
                    playerPosition = .Right
                    player.runAction(goRight)
                    break
                default:
                    break
                }
            }
            else {
                switch (playerPosition) {
                case .Right:
                    playerPosition = .Center
                    player.runAction(goCenter)
                    break
                case .Center:
                    playerPosition = .Left
                    player.runAction(goLeft)
                    break
                default:
                    break
                }
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
        // Get Touch
        let touch = touches.anyObject() as UITouch
        let touchPosition = touch.locationInNode(self)
        
        // Test State
        if gameState == stateControl.Title {
            
            // Start Game
            gameState = .Run
            self.title.runAction(fadeOut, completion: { () -> Void in
                self.score.runAction(fadeIn)
                self.obstacle.runAction(fadeIn)
                self.player.runAction(fadeIn, completion: { () -> Void in
                    self.obstacleControl(true)
                })
            })
        }
        else if gameState == stateControl.End {
            
            // Reload Scene
            NSNotificationCenter.defaultCenter().postNotificationName("loadScene", object: nil)
        }
    }
    
    // MARK: Physics
    func didBeginContact(contact: SKPhysicsContact!) {
        if !self.collided {
            self.collided = true
            self.gameState = .End
            self.score.runAction(fadeOut)
            self.player.runAction(fadeOut)
            self.title.text = self.score.text
            self.title.runAction(fadeIn)
        }
    }
}
