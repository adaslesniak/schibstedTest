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
        let data = ModelCtrl.content.articles[indexPath.row]
        cell.textLabel?.text = data.title
        print("asking for image for: \(data.title)")
        data.getImage() { [weak cell] articleIcon in
            ExecuteOnMain {
                print("got callback for cell at: \(data.title)")
                guard let oldCell = cell else {
                    print("!!!ups - there is no more cell to apply image")
                    return
                }
                guard oldCell.textLabel?.text == data.title else {
                    print("!!!ups - image is outdated, cell was reused for something else")
                    return
                } //cell was reused and callback is too late
                oldCell.imageView?.image = articleIcon
                oldCell.imageView?.frame = CGRect(x: 0, y: 0, width: oldCell.bounds.height, height: oldCell.bounds.height)
                oldCell.imageView?.contentMode = .scaleAspectFill
                print("img frame: \(oldCell.imageView!.frame)")
            }
        }
        return cell
    }
    
}
