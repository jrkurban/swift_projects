//
//  AciklamalarViewController.swift
//  TableView Uygulamasi
//
//  Created by Batuhan Alp Kurban on 24.04.2023.
//

import UIKit

class AciklamalarViewController: UIViewController {

    @IBOutlet weak var lblMarkaAciklama: UITextView!
    var aciklama : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblMarkaAciklama.text = aciklama
    }
    
    func setAciklama(a : String) {
        aciklama = a
        if isViewLoaded {
            lblMarkaAciklama.text = aciklama
        }
    }
    

    

}
