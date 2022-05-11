struct counter {
    static var score = 0
    static var time = 0.0
}

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball: SKSpriteNode!
    let cam = SKCameraNode()
    var anchor = CGPoint(x: 0.5, y: -176.364)
    
    
    override func didMove(to view: SKView) {
        //let background = SKSpriteNode(imageNamed: "background")
        //background.position = CGPoint(x: 0.5, y: -180.0)
        //addChild(background)
    }
    
    override func sceneDidLoad() {

        ball = (self.childNode(withName: "ball") as! SKSpriteNode)
        self.camera = cam
    }
    
    override func update(_ currentTime: TimeInterval) {
        cam.position = ball.position
        
    }
    
    func jump(){
        let randomDouble = Double.random(in: 2.71828...3.14159)
        ball.physicsBody?.velocity = CGVector(dx: 0.0, dy: counter.time * 600)
        ball.physicsBody?.angularVelocity = randomDouble * 2
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [self] (t) in
            print(ball.zRotation)
            let degree = ball.zRotation
            if(degree >= -0.5 && degree <= 0.5){
                counter.score += 1
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 3.5, repeats: false) { [self] (t) in
            self.ball.physicsBody?.angularVelocity = 0
            self.ball.zRotation = 0
            self.ball.position = CGPoint.init(x: 0.5, y: -196.364)
        }
        
    }
}
