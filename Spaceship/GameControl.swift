//
//  GameControl.swift
//  Spaceship
//
//  Created by Ricardo Rauber on 9/10/14.
//  Copyright (c) 2014 BEPiD POA. All rights reserved.
//

import UIKit

import SpriteKit

// Screen Size
let DEVICE_SIZE = UIScreen.mainScreen().bounds
let WIDTH = DEVICE_SIZE.size.width * 2
let HEIGHT = DEVICE_SIZE.size.height * 2

enum positionInScreen {
    case Left
    case Center
    case Right
}

// Lanes
let laneLeft: CGFloat = WIDTH / 3 / 2
let laneCenter: CGFloat = WIDTH / 2
let laneRight: CGFloat = WIDTH - laneLeft

// Control
enum stateControl {
    case Title
    case Run
    case End
}

// Actions
let fxTime: NSTimeInterval = 0.2
let fadeOut = SKAction.fadeAlphaTo(0, duration: fxTime)
let fadeIn = SKAction.fadeAlphaTo(1, duration: fxTime)
let moveDown = SKAction.moveToY(-HEIGHT/4, duration: fxTime * 6)
let goLeft = SKAction.moveToX(laneLeft, duration: fxTime)
let goCenter = SKAction.moveToX(laneCenter, duration: fxTime)
let goRight = SKAction.moveToX(laneRight, duration: fxTime)

// Physics
let heroCategory: UInt32 = 0x1 << 0
let obstacleCategory: UInt32 = 0x1 << 1