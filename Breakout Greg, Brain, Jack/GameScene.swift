//
//  GameScene.swift
//  Breakout Greg
//
//  Created by gpodkowa0302 on 5/1/18.
//  Copyright © 2018 gpodkowa0302. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
  
    //Defining ball and paddle nodes
    var ball:SKSpriteNode!
    var paddle:SKSpriteNode!
    
    //When app starts, set names to the ball and paddle nodes
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "Ball") as! SKSpriteNode
        paddle = self.childNode(withName: "Paddle") as! SKSpriteNode
     
        //Apply impulse so the ball will move around
        ball.physicsBody?.applyImpulse(CGVector(dx: 100, dy: 100))
        
        //Setting the border for the app so the ball won't go out of bounds
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        self.physicsBody = border
        self.physicsWorld.contactDelegate = self
    }
 
    //Starts when the user begins touching the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle.position.x = touchLocation.x
        }
    }
    //Checking for the names of the nodes we set earlier
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyAName = contact.bodyA.node?.name
        let bodyBName = contact.bodyB.node?.name
       
        //Logic to determine what happens to the bricks
        if bodyAName == "Ball" && bodyBName == "Brick" || bodyAName == "Brick" && bodyBName == "Ball"{
            if bodyAName == "Brick" {
                contact.bodyA.node?.removeFromParent()
            } else if bodyBName == "Brick" {
                contact.bodyB.node?.removeFromParent()
            }
        }
    }
    //function to move the paddle based on where the user places their finger
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle.position.x = touchLocation.x
        }
    }
}
// What the hake

