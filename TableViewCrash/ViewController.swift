import SwiftException
import UIKit

class ViewController: UIViewController {
    static let cellReuseIdentifier = "UITableViewCell"

    private var tableView: UITableView?
    private var timer: Timer!

    private var cellCount = 0

    override func viewDidLoad() {
        setupTableView()

        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { [weak self] _ in
            self?.timerTick()
        })
    }

    private func setupTableView() {
        let previousContentOffset = tableView?.contentOffset
        tableView?.removeFromSuperview()

        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ViewController.cellReuseIdentifier)

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.topAnchor.constraint(equalTo: tableView.topAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
        ])

        if let contentOffset = previousContentOffset {
            tableView.setContentOffset(contentOffset, animated: false)
        }

        self.tableView = tableView
    }

    private func timerTick() {
        let random = Int.random(in: 1 ... 10)
        let toInsert = random > 4 ? 10 : 11

        let indexPaths = (0 ..< toInsert).map { $0 + cellCount }.map { IndexPath(row: $0, section: 0) }
        cellCount += 10

        do {
            try ObjC.catchException {
                tableView?.performBatchUpdates({
                    tableView?.insertRows(at: indexPaths, with: .automatic)
                })
                print("Batch updates finished")
            }
        } catch {
            print("Exception caught")
            setupTableView()
            tableView?.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return cellCount
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellReuseIdentifier)!
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
