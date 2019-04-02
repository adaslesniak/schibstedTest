// [SchibstedTest] created by: Adas Lesniak on: 02/04/2019
import UIKit



class ArticleViewCtrl: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var backBtn: UIButton! //don't like code execution defined in IB, so always assign Buttons instead of Actions
    
    private var delgate: ContentViewDelegate!
    private var card: ArticleCard!
    
    public static func instantiate(with article: ArticleCard, delegate: ContentViewDelegate) -> ArticleViewCtrl {
        let ctrl = ArticleViewCtrl(nibName: "ArticleView", bundle: nil)
        ctrl.delgate = delegate
        ctrl.card = article
        if ctrl.view != nil {
            ctrl.setContent() //at this stage view could not load yet
        }
        return ctrl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if card != nil {  //this could load before card is assigned
            setContent()
        }
        backBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    private var isFetchingContent = false
    private func setContent() {
        guard !isFetchingContent else {
            return
        }
        isFetchingContent = true
        ModelCtrl.article(card.id) { [weak self] article in
            guard let self = self, let article = article else {
                print("ERROR without proper log in ArticleViewCtrl.setContent")
                return
            }
            self.textView.text = article.text
            self.titleView.text = article.title
            self.isFetchingContent = false
        }
    }
    
    @objc private func close() {
        delgate.onClosed()
    }
    
    
    
}
