//
//  DataSource.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 23.04.22.
//

import Foundation
import UIKit

class TableViewDataSource: NSObject {
    var sections: [ListSection]

    init(sections: [ListSection]) {
        self.sections = sections
    }
}

extension TableViewDataSource: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].type.rawValue.uppercased()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.identifer, for: indexPath) as? ItemCellInterface {
            cell.configure(with: sections[indexPath.section].items[indexPath.row])
            return cell as! UITableViewCell
        }
        return UITableViewCell()
    }


}
