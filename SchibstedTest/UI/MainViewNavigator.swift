//[ShibstedTest] created by: Adas Lesniak on: 01/04/2019 

import UIKit


//It's not classic approach, but to avoid MassiveViewController I belive in idea of "separation of concerns" - this one view controller is responsible for navigating between views. Navigation between views should happened here and only here (or other ViewNavigators if app become big and has dozens of subviews) - it definitely should not be "one more concern of multiple view controllers"
class MainViewNavigator: UINavigationController, ContentListViewDelegate, ContentViewDelegate {

    private var detailViewCtrl: UIViewController?
    
    static func instantiate() -> MainViewNavigator {
        let contentListVC = ContentListViewCtrl.instantiate()
        let this = MainViewNavigator.init(rootViewController: contentListVC)
        this.isNavigationBarHidden = true
        contentListVC.setDelegate(this)
        return this
    }


    // ========= LIST VIEWS DELEGATE ===========
    func onTopicSelection(_ selected: TopicCard) {
        detailViewCtrl = TopicViewCtrl.instantiate(with: selected, delegate: self)
        pushViewController(detailViewCtrl!, animated: true)
    }
    
    func onArticleSelection(_ selected: ArticleCard) {
        detailViewCtrl = ArticleViewCtrl.instantiate(with: selected, delegate: self)
        pushViewController(detailViewCtrl!, animated: true)
    }
    
    
    // ========= DETAILS VIEWS DELEGATE ==========
    func closeDetailView() {
        popViewController(animated: true)
        detailViewCtrl = nil
    }
}

