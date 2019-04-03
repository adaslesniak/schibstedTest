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
        ModelCtrl.content.updateAboutArticles(self) { [weak self] in
            self?.tableView.reloadData()
        }
        tableView.reloadData()
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
        cell.selectionStyle = .none
        let data = ModelCtrl.content.articles[indexPath.row]
        cell.textLabel?.text = data.title
        data.getImage() { [weak cell] articleIcon in
            ExecuteOnMain {
                guard let oldCell = cell,  oldCell.textLabel?.text == data.title else {
                    return
                } //cell was reused or even removed and callback is too late
                let cellHeight = oldCell.bounds.height
                oldCell.imageView?.image = articleIcon
                oldCell.imageView?.frame = CGRect(
                    x: 0,
                    y: 0,
                    width: cellHeight,
                    height: cellHeight)
                oldCell.textLabel?.frame = CGRect(
                    x: cellHeight,
                    y: 0,
                    width: oldCell.bounds.width - cellHeight,
                    height: cellHeight)
            }
        }
        return cell
    }
    
}
