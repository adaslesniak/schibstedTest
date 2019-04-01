// [SchibstedTest] created by: Adas Lesniak on: 02/04/2019
import UIKit



class ArticleViewCtrl: UIViewController {
    
    private var delgate: ContentViewDelegate!
    private var card: ArticleCard!
    
    public static func instantiate(with article: ArticleCard, delegate: ContentViewDelegate) -> ArticleViewCtrl {
        let ctrl = ArticleViewCtrl(nibName: "ArticleView", bundle: nil)
        ctrl.delgate = delegate
        ctrl.card = article
        return ctrl
    }
    
    
    
}
