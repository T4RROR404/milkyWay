//
//  GameOverScene.swift
//  milkyWay
//
//  Created by insomnia on 09.07.2022.
//

import SpriteKit

class GameOverScene: SKScene {
    
    let restartButton = SKLabelNode(fontNamed: "pricedown")
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        self.addChild(background)
        
        let gameOverLabel = SKLabelNode(fontNamed: "pricedown")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 200
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.7)
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        let scoreLabel = SKLabelNode(fontNamed: "pricedown")
        scoreLabel.text = "Score: \(gameScore)"
        scoreLabel.fontSize = 125
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.55)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        let defaults = UserDefaults()
        var highScoreNumber = defaults.integer(forKey: "hightScoreSaved")
        
        if gameScore > highScoreNumber {
            highScoreNumber = gameScore
            defaults.set(highScoreNumber, forKey: "hightScoreSaved")
        }
        
        let hightScoreLabel = SKLabelNode(fontNamed: "pricedown")
        hightScoreLabel.text = "Hight Score: \(highScoreNumber)"
        hightScoreLabel.fontSize = 125
        hightScoreLabel.fontColor = SKColor.white
        hightScoreLabel.zPosition = 1
        hightScoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.45)
        self.addChild(hightScoreLabel)
        
        restartButton.text = "Restart"
        restartButton.fontSize = 90
        restartButton.fontColor = SKColor.white
        restartButton.zPosition = 1
        restartButton.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.3)
        self.addChild(restartButton)        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            
            if restartButton.contains(pointOfTouch) {
                let sceneToMove = GameScene(size: self.size)
                sceneToMove.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMove, transition: myTransition)
            }
        }
    }
}
