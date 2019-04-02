// [SchibstedTest] created by: Adas Lesniak on: 01/04/2019
import UIKit

//FIXME: duplicated code with TopicsListViewCtrl
class ArticlesListViewCtrl: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    typealias SelectionListener = (ArticleCard) -> Void
    private var onSelection: SelectionListener!
    private var tableView: UITableView { return view as! UITableView }
    private let cellId = "articles_table_cell"
    
    
    public static func instantiate(_ whenArticleSelected: @escaping SelectionListener) -> ArticlesListViewCtrl {
        let ctrl = ArticlesListViewCtrl()
        ctrl.onSelection = whenArticleSelected
        return ctrl
    }
    
    override func loadView() {
        let myView = UITableView()
        myView.delegate = self
        myView.dataSource = self
        view = myView
        myView.backgroundColor = UIColor.red
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelection(ModelCtrl.content.articles[indexPath.row])
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelCtrl.content.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) ??
            UITableViewCell(style: .default, reuseIdentifier: cellId)
        let data = ModelCtrl.content.articles[indexPath.row]
        cell.textLabel?.text = data.title
        data.getImage() { [weak cell] articleIcon in
            guard let oldCell = cell else { return }
            guard oldCell.textLabel?.text == data.title else { return } //cell was reused and callback is too late
            oldCell.imageView?.image = articleIcon
        }
        return cell
    }
    
}
