// [SchibstedTest] created by: Adas Lesniak on: 02/04/2019
import UIKit


class TopicViewCtrl: UIViewController {
    
    private var delegate: ContentViewDelegate!
    private var card: TopicCard!
    
    public static func instantiate(with topic: TopicCard, delegate: ContentViewDelegate) -> TopicViewCtrl {
        let ctrl = TopicViewCtrl(nibName: "TopicView", bundle: nil)
        ctrl.delegate = delegate
        ctrl.card = topic
        return ctrl
    }
    
    
    
}
