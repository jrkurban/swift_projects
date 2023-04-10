//
//  ViewController.swift
//  TableView Uygulamasi
//
//  Created by Batuhan Alp Kurban on 10.04.2023.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var table: UITableView!
    
    var markalar : [String] = ["Apple","Samsung","Xiaomi"]
    var sayac : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        table.dataSource = self
        table.delegate = self
        
        
        //self.title = "Markalar - 1"
        //self.navigationController?.navigationBar.prefersLargeTitles = false
        
        let addButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        addButton.tintColor = UIColor.red
        self.navigationItem.leftBarButtonItem = addButton
        
        
        //EditButton
        
        let editButton = editButtonItem
        editButton.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItems?.append(editButton)
    }
    
    @objc func addButtonClicked(){
        let alert = UIAlertController(title: "Marka Ekle", message: "Eklemek İstediğiniz Markayı Giriniz", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(configurationHandler: { txtMarkaAdi in
            txtMarkaAdi.placeholder = "Marka Adı"
        })
       
        let actionAdd = UIAlertAction(title: "Ekle", style: UIAlertAction.Style.default, handler: { action in
            
            let firstTextField = alert.textFields![0] as UITextField
            self.markaEkle(markaAdi: firstTextField.text!)
            
        })
        
        let actionCancel = UIAlertAction(title: "İptal", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(actionAdd)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func btnAddClicked(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Marka Ekle", message: "Eklemek İstediğiniz Markayı Giriniz", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(configurationHandler: { txtMarkaAdi in
            txtMarkaAdi.placeholder = "Marka Adı"
        })
       
        let actionAdd = UIAlertAction(title: "Ekle", style: UIAlertAction.Style.default, handler: { action in
            
            let firstTextField = alert.textFields![0] as UITextField
            self.markaEkle(markaAdi: firstTextField.text!)
            
        })
        
        let actionCancel = UIAlertAction(title: "İptal", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(actionAdd)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return markalar.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell : UITableViewCell = UITableViewCell()
        let cell : UITableViewCell = table.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = markalar[indexPath.row]
        return cell
        
    }
    
    func markaEkle(markaAdi : String) {
        //let markaAdi : String = "\(sayac). Yeni Marka"
        //sayac = sayac + 1
        //markalar.append(markaAdi)
        //let indexPath : IndexPath = IndexPath(row: markalar.count-1, section: 0)
        
        markalar.insert(markaAdi, at: 0)
        let indexPath : IndexPath = IndexPath(row: 0, section: 0)
        
        //Tabloya ekleme
        table.insertRows(at: [indexPath], with: UITableView.RowAnimation.left)
        
    }


}

