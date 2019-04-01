//[SchibstedTest] created by: Adas Lesniak on: 01/04/2019
import UIKit

protocol ContentListViewDelegate {
    func onArticleSelection(_ selected: ArticleCard)
    func onTopicSelection(_ selected: TopicCard)
}


class ContentListViewCtrl : UIViewController {
    
    @IBOutlet weak var articlesList: UITableView!
    @IBOutlet weak var topicsList: UITableView!
    @IBOutlet weak var modeSwitch: UISegmentedControl!
    

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
        ModelCtrl.content.updateAboutTopics(self) {
            fatalError("NOT_IMPLEMENTED")
        }
        ModelCtrl.content.updateAboutArticles(self) {
            fatalError("NOT_IMPLEMENTED")
        }
    }
}
