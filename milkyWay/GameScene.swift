//
//  GameScene.swift
//  milkyWay
//
//  Created by insomnia on 04.07.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let player = SKSpriteNode(imageNamed: "playerShip")
    let shotSound = SKAction.playSoundFileNamed("shot", waitForCompletion: false)
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    var gameArea: CGRect
    
    override init(size: CGSize) {
        
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playbleWight = size.height/maxAspectRatio
        let margin = (size.width - playbleWight) / 2
        gameArea = CGRect(x: margin, y: 0, width: playbleWight, height: size.height)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        
        player.setScale(1)
        player.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.1)
        player.zPosition = 2
        self.addChild(player)
        
        startNewLevel()
    }
    
    func startNewLevel() {
        
        let spawn = SKAction.run(spawnEnemy)
        let waitToSpawn = SKAction.wait(forDuration: 1)
        let spawnSequence = SKAction.sequence([spawn, waitToSpawn])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        self.run(spawnForever)
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
    
    func spawnEnemy() {
        
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        let statrPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        
        let enemy = SKSpriteNode(imageNamed: "enemyShip")
        enemy.setScale(1)
        enemy.position = statrPoint
        enemy.zPosition = 2
        self.addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: 1.5)
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy])
        enemy.run(enemySequence)
        
        let dx = endPoint.x - statrPoint.x
        let dy = endPoint.y - statrPoint.y
        let amountToRotate = atan2(dy, dx)
        enemy.zRotation = amountToRotate
        
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
            
            if player.position.x > gameArea.maxX - player.size.width / 2  {
                player.position.x = gameArea.maxX - player.size.width / 2
            }
            
            if player.position.x < gameArea.minX + player.size.width / 2  {
                player.position.x = gameArea.minX + player.size.width / 2
            }
        }
    }

}
