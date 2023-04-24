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
    
    var masterView : ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblMarkaAciklama.text = aciklama
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    func setAciklama(a : String) {
        aciklama = a
        if isViewLoaded {
            lblMarkaAciklama.text = aciklama
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        masterView?.markaAciklamasi = lblMarkaAciklama.text
        lblMarkaAciklama.resignFirstResponder()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblMarkaAciklama.becomeFirstResponder()
    }
    

    

}
