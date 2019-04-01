//[ShibstedTest] created by: Adas Lesniak on: 01/04/2019 

import UIKit


//It's not classic approach, but to avoid MassiveViewController I belive in idea of "separation of concerns" - this one view controller is responsible for navigating between views. Navigation between views should happened here and only here (or other ViewNavigators if app become big and has dozens of subviews) - it definitely should not be "one more concern of multiple view controllers"
class MainViewNavigator: UINavigationController, ContentListViewDelegate, ContentViewDelegate {

    private var baseViewController: ContentListViewCtrl!
    private var detailViewCtrl: UIViewController?
    
    static func instantiate() -> MainViewNavigator {
        return MainViewNavigator()
    }
    
    //concrete implementation should be probably changed depending on app scale, but since navigation is contained here that is relatively easy task
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let mainListVC = ContentListViewCtrl.instantiate(delegate: self)
        present(mainListVC, animated: false)
        baseViewController = mainListVC
    }


    // ========= LIST VIEWS DELEGATE ===========
    func onTopicSelection(_ selected: TopicCard) {
        detailViewCtrl = TopicViewCtrl.instantiate(with: selected, delegate: self)
        present(detailViewCtrl!, animated: true)
    }
    
    func onArticleSelection(_ selected: ArticleCard) {
        detailViewCtrl = ArticleViewCtrl.instantiate(with: selected, delegate: self)
        present(detailViewCtrl!, animated: true)
    }
    
    
    // ========= DETAILS VIEWS DELEGATE ==========
    func onClosed() {
        detailViewCtrl?.dismiss(animated: true) //if here they are presented here they should be dismissed
    }
    
    func onSwipedToNext() {
        //TODO: create next to left and animate it to center while animating current out to right
    }
    
    func onSwipedToPrevious() {
        //TODO: create previous on right and animate it to center while animating current out to left
    }
}

