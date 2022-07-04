//
//  GameScene.swift
//  milkyWay
//
//  Created by insomnia on 04.07.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let player  = SKSpriteNode(imageNamed: "playerShip")
    let shotSound = SKAction.playSoundFileNamed("shot", waitForCompletion: false)
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        
        player.setScale(1)
        player.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.2)
        player.zPosition = 2
        self.addChild(player)
    }
    
    func fire() {
        let shot = SKSpriteNode(imageNamed: "bullet")
        shot.setScale(0.5)
        shot.position = player.position
        shot.zPosition = 1
        self.addChild(shot)
        
        let moveBullet = SKAction.moveTo(y: self.size.height + shot.size.height, duration: 1)
        let deleteBullet  = SKAction.removeFromParent()
        let bulletSequence = SKAction.sequence([shotSound, moveBullet, deleteBullet])
        shot.run(bulletSequence)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fire()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            player.position.x += amountDragged
        }
    }

}
