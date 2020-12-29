//
//  ViewController.swift
//  StrectchyHeader
//
//  Created by Hamza Mustafa on 29/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataArray = ["demo1","demo2","demo3","demo4","demo5"]
    var HeaderView : UIView!
    var NewHeaderLayer : CAShapeLayer!
    private let HeaderHeight : CGFloat = 420
    private let HeaderCut : CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        tableView.backgroundColor = UIColor.clear
        HeaderView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(HeaderView)
        
        NewHeaderLayer = CAShapeLayer()
        NewHeaderLayer.fillColor = UIColor.black.cgColor
        HeaderView.layer.mask = NewHeaderLayer
        
        let newHeight = HeaderHeight - HeaderCut / 2
        tableView.contentInset = UIEdgeInsets(top: newHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -newHeight)
        self.setupNewView()
    }
    
    func setupNewView() {
        let newHeight = HeaderHeight - HeaderCut / 2
        var getHeaderFrame = CGRect(x: 0, y: -newHeight, width: tableView.bounds.width, height: HeaderHeight)
        
        if tableView.contentOffset.y < newHeight {
            getHeaderFrame.origin.y = tableView.contentOffset.y
            getHeaderFrame.size.height = -tableView.contentOffset.y + HeaderCut / 2
        }
        
        HeaderView.frame = getHeaderFrame
        let cutDirection = UIBezierPath()
        cutDirection.move(to: CGPoint(x: 0, y: 0))
        cutDirection.addLine(to: CGPoint(x: getHeaderFrame.width, y: 0))
        cutDirection.addLine(to: CGPoint(x: getHeaderFrame.width, y: getHeaderFrame.height))
        cutDirection.addLine(to: CGPoint(x: 0, y: getHeaderFrame.height - HeaderCut))
        NewHeaderLayer.path = cutDirection.cgPath
    }
}

extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "myTableViewCellid", for: indexPath) as? myTableViewCell {
            cell.myTitle.text = dataArray[indexPath.row]
            cell.myImg.image = UIImage(named: "banner")
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tableView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.setupNewView()
    }
}
