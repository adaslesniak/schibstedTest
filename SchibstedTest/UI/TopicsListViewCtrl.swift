// [SchibstedTest] created by: Adas Lesniak on: 02/04/2019
import UIKit

//FIXME: duplicated code with ArticlesViewCtrl
class TopicsListViewCtrl: UIViewController, UITableViewDelegate, UITableViewDataSource {

    typealias SelectionListener = (TopicCard) -> Void
    private var onSelection: SelectionListener!
    private var tableView: UITableView { return view as! UITableView }
    private let cellId = "topics_table_cell"
    
    
    public static func instantiate(_ whenTopicSelected: @escaping SelectionListener) -> TopicsListViewCtrl {
        let ctrl = TopicsListViewCtrl()
        ctrl.onSelection = whenTopicSelected
        return ctrl
    }
    
    override func loadView() {
        let myView = UITableView()
        myView.delegate = self
        myView.dataSource = self
        view = myView
        ModelCtrl.content.updateAboutTopics(self) { [weak self] in
            self?.tableView.reloadData()
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelection(ModelCtrl.content.topics[indexPath.row])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelCtrl.content.topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) ??
            UITableViewCell(style: .default, reuseIdentifier: cellId)
        let data = ModelCtrl.content.topics[indexPath.row]
        cell.textLabel?.text = data.title
        return cell
    }
}
