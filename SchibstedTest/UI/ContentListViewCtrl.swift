//[SchibstedTest] created by: Adas Lesniak on: 01/04/2019
import UIKit

protocol ContentListViewDelegate {
    func onArticleSelection(_ selected: ArticleCard)
    func onTopicSelection(_ selected: TopicCard)
}


class ContentListViewCtrl : UIViewController {
    
    @IBOutlet weak var listPlaceholder: UIView! //it's there to define place for lists
    @IBOutlet weak var modeSwitch: UISegmentedControl!
    private var articlesList: ArticlesListViewCtrl!
    private var topicsList: TopicsListViewCtrl!
    

    private enum Mode {
        case topics
        case articles
    }
    private var currentMode = Mode.articles
    private var delegate: ContentListViewDelegate!
    
    //that should be only allowed - idea of init(nibName: bundle:) is destroying encapsulation. It's nobody else business except this controller what is the bundle and what is the name of nib file
    public static func instantiate(delegate: ContentListViewDelegate) -> ContentListViewCtrl {
        let ctrl = ContentListViewCtrl(nibName: "ContentListView", bundle: nil)
        ctrl.delegate = delegate
        return ctrl
    }
    
    override func viewDidLoad() {
        articlesList = ArticlesListViewCtrl.instantiate(delegate.onArticleSelection)
        addChild(articlesList)
        articlesList.view.frame = view.bounds
        view.insertSubview(articlesList.view, at: 0)
        topicsList = TopicsListViewCtrl.instantiate(delegate.onTopicSelection)
        addChild(topicsList)
        topicsList.view.frame = view.bounds
        view.insertSubview(topicsList.view, at: 0)
        modeSwitch.addTarget(self, action: #selector(onModeChanged), for: .valueChanged)
    }
    
    @objc private func onModeChanged() {
        if modeSwitch.selectedSegmentIndex == 0 {
            currentMode = .articles
            view.sendSubviewToBack(topicsList.view)
        } else {
            currentMode = .topics
            view.sendSubviewToBack(articlesList.view)
        }
        
    }
    
    
}
