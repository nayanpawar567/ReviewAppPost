//
//  ViewController.swift
//  ReviewApp
//
//  Created by Nayan Pawar on 02/03/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var reviewArray = [ReviewData]()
    
//    var rating: [BaseModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
//        getData()
//        getDataAlamofire()
        postReq()
    }

    
    func setUpUI(){
        tableView.delegate = self
        tableView.dataSource = self
    }

//    func getData() {
//        NetworkManager.shared.getReviews { rating in
//            print(rating)
//            self.reviewArray.append(contentsOf: rating.reviewData!)
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    func getDataAlamofire() {
        NetworkManager.shared.getReviewAlamofire { data, error in
            guard let data else { return }
            self.reviewArray.append(contentsOf: data.reviewData!)
            print(error)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func postReq() {
        NetworkManager.shared.postReq { msg in
            print(msg)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as? ReviewCell
        else{
            fatalError()
        }
        let review = reviewArray[indexPath.row]
        cell.lblFName.text = review.first_name
        cell.lblLName.text = review.last_name
        cell.lblReview1.text = review.review
        
        
        return cell
    }
}

