//
//  GameScene.swift
//  DiveIntoSpriteKit
//
//  Created by Paul Hudson on 16/10/2017.
//  Copyright © 2017 Paul Hudson. All rights reserved.
//

import GameplayKit
import SpriteKit
import CoreMotion

@objcMembers
class GameScene: SKScene, SKPhysicsContactDelegate {
    let player = SKSpriteNode(imageNamed: "player-rocket")
    let motionManager = CMMotionManager()
    var gameTimer: Timer?
    let music = SKAudioNode(fileNamed: "exhilarate")
    let scoreLabel = SKLabelNode(fontNamed: "AvenirNextCondensed-Bold")
    var gameOverImage: SKSpriteNode?
    var restartButton: SKNode! = nil
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var touchingPlayer = false
    var gameOver = false
    
    override func didMove(to view: SKView) {
        scoreLabel.zPosition = 2
        scoreLabel.position.y = 150
        addChild(scoreLabel)
        score = 0
        
        let background = SKSpriteNode(imageNamed: "space")
        background.zPosition = -1
        addChild(background)
        
        restartButton = SKSpriteNode(texture: SKTexture(imageNamed: "restart"), size: CGSize(width: 264, height: 66))
        restartButton.position.y = -150
        restartButton.zPosition = 2
        restartButton.isHidden = true
        
        addChild(restartButton)
        
        if let particles = SKEmitterNode(fileNamed: "SpaceDust") {
            particles.position.x = 512
            particles.advanceSimulationTime(10)
            addChild(particles)
        }
        
        player.position.x = -400
        player.zPosition = 1
        addChild(player)
        
        gameOverImage = SKSpriteNode(imageNamed: "gameOver-1")
        gameOverImage?.zPosition = 10
        gameOverImage?.isHidden = true
        
        if let gameOverImage = gameOverImage {
            addChild(gameOverImage)
        }
       
        motionManager.startAccelerometerUpdates()
        gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.categoryBitMask = 1
        
        physicsWorld.contactDelegate = self
        
        addChild(music)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappesNodes = nodes(at: location)
        
        if tappesNodes.contains(player) {
            touchingPlayer = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchingPlayer, let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        player.position = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchingPlayer = false
        
        for touch in touches {
            let location = touch.location(in: self)
            if self.restartButton.contains(location) {
                restart()
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if !gameOver {
            score +=  1
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node,
              let nodeB = contact.bodyB.node else { return }
        
        if nodeA == player {
            playerHit(nodeB)
        } else {
            playerHit(nodeA)
        }
    }
    
    func playerHit(_ node: SKNode) {
        if node.name == "bonus" {
            score += 1
            node.removeFromParent()
            return
        }
        
        gameOver = true
        player.removeFromParent()
        music.removeFromParent()
        
        if let particles = SKEmitterNode(fileNamed: "GameOver") {
            particles.position = player.position
            particles.zPosition = 3
            addChild(particles)
        }
        let sound = SKAction.playSoundFileNamed("explosion", waitForCompletion: false)
        run(sound)
        
        gameOverImage?.isHidden = false
        gameTimer?.invalidate()
        
        restartButton.isHidden = false
    }
    
    func createEnemy() {
        let randomDistribution = GKRandomDistribution(lowestValue: -350, highestValue: 350)
        let sprite = SKSpriteNode(imageNamed: "fish")
        
        sprite.position = CGPoint(x: 1200, y: randomDistribution.nextInt())
        sprite.name = "enemy"
        sprite.zPosition = 1
        
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.contactTestBitMask = 1
        sprite.physicsBody?.categoryBitMask = 0
        
        createBonus()
    }
    
    func createBonus() {
        let randomDistribution = GKRandomDistribution(lowestValue: -350, highestValue: 350)
        let sprite = SKSpriteNode(imageNamed: "sea-junk")
        
        sprite.position = CGPoint(x: 1200, y: randomDistribution.nextInt())
        sprite.name = "bonus"
        sprite.zPosition = 1
        
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.contactTestBitMask = 1
        sprite.physicsBody?.categoryBitMask = 0
        sprite.physicsBody?.collisionBitMask = 0
    }
    
    func restart() {
        children.forEach({
            if $0.name == "enemy" || $0.name == "bonus" {
                $0.removeFromParent()
            }
        })
        
        score = 0
        gameOver = false
        gameOverImage?.isHidden = true
        restartButton.isHidden = true
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        
        player.position = CGPoint(x: -400, y: 0)
        
        addChild(player)
        addChild(music)
    }
}

