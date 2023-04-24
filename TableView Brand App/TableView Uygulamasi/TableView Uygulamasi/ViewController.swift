//
//  ViewController.swift
//  TableView Uygulamasi
//
//  Created by Batuhan Alp Kurban on 10.04.2023.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var table: UITableView!
    
    var fileURL: URL!
    
    var markalar : [String] = []
    var sayac : Int = 0
    
    var selectedRow : Int = -1
    
    var markaAciklamalari : [String] = []
    
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
        
        let baseURL = try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
        
        print(baseURL)
        
        fileURL = baseURL.appendingPathComponent("Markalar.txt")
        
        
        //UserDefaults'taki verileri siler
        //UserDefaults.standard.removeObject(forKey: "markalar")
        loadData()
    }
    
    @objc func addButtonClicked(){
        
        if table.isEditing == true {
            return
        }
        
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
        
        if table.isEditing {
            return
        }
        
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
        markaAciklamalari.insert("Girilmedi", at:0)
        let indexPath : IndexPath = IndexPath(row: 0, section: 0)
        
        //Tabloya ekleme
        table.insertRows(at: [indexPath], with: UITableView.RowAnimation.left)
        saveData()
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        performSegue(withIdentifier: "goAciklamalar", sender: self)
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == .delete {
            markalar.remove(at: indexPath.row)
            markaAciklamalari.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
            saveData()
        }
    }
    
    func saveData(){
        UserDefaults.standard.set(markalar, forKey: "markalar")
        UserDefaults.standard.set(markaAciklamalari, forKey: "aciklamalar")
        let veriler = NSArray(array: markalar)
        do{
            try veriler.write(to: fileURL)
        } catch {
            print("dosyaya yazarken hata meydana geldi")
        }
    }
    
    func loadData(){
        //if let loadedData : [String] = UserDefaults.standard.value(forKey: "markalar") as? [String] {
        if let loadedData : [String] = NSArray(contentsOf: fileURL) as? [String] {
            markalar = loadedData
            
        }
        if let aciklamalar : [String] = UserDefaults.standard.value(forKey: "aciklamalar") as? [String] {
            markaAciklamalari = aciklamalar
        }
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Seçilen Marka : \(markalar[indexPath.row])")
        
        performSegue(withIdentifier: "goAciklamalar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let aciklamalarView : AciklamalarViewController = segue.destination as! AciklamalarViewController
        selectedRow = table.indexPathForSelectedRow!.row
        aciklamalarView.setAciklama(a: markaAciklamalari[selectedRow])
    }


}

