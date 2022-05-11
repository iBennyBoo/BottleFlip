import UIKit
import SpriteKit
import GameplayKit

var play: GameScene!
var flip: Bool = false

class GameViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    var time = 0.00
    var timer: Timer!
    
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(GameViewController.viewDidLoad), userInfo: nil, repeats: true)

    }
    
    @objc func updateTimer(){
        time = time + 0.01
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimer()
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
                    UIDevice.current.setValue(value, forKey: "orientation")
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                play = sceneNode
                // Copy gameplay related content over to the scene
                //sceneNode.entities = scene.entities
                //sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if(flip == false){
            time = 0
            flip = true
            button.setTitle("Flip!", for: .normal)
        } else if(flip == true){
            timer.invalidate()
            if(time > 3){
                time = 3
            }
            print(time)
            flip = false
            button.setTitle("Charge!", for: .normal)
            counter.time = time
            play.jump()
            button.isHidden = true
            Timer.scheduledTimer(withTimeInterval: 3.5, repeats: false) { [self] (t) in
                label.text! = "Score: \(counter.score)"
                button.isHidden = false
                timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(GameViewController.viewDidLoad), userInfo: nil, repeats: true)
                }
            
        }
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
