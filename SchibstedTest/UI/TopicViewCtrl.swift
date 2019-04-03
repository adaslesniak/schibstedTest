// [SchibstedTest] created by: Adas Lesniak on: 02/04/2019
import UIKit


class TopicViewCtrl: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    private var delegate: ContentViewDelegate!
    private var card: TopicCard!
    
    public static func instantiate(with topic: TopicCard, delegate: ContentViewDelegate) -> TopicViewCtrl {
        let ctrl = TopicViewCtrl(nibName: "TopicView", bundle: nil)
        ctrl.delegate = delegate
        ctrl.card = topic
        if ctrl.view != nil {
            ctrl.setContent()
        }
        return ctrl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if card != nil {
            setContent()
        }
        backBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    private var isFetchingContent = false
    private func setContent() {
        guard !isFetchingContent else {
            return //no need to do it multiple times
        }
        isFetchingContent = true
        ModelCtrl.topic(card.id) { [weak self] result in
            guard let self = self, let topic = result, topic.id == self.card.id else {
                return //too late
            }
            self.textView.text = topic.type
            self.titleLabel.text = topic.title
        }
    }
    
    @objc private func close() {
        delegate.closeDetailView()
    }
    
}
