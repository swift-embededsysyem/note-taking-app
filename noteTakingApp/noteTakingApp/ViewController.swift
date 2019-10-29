//
//  ViewController.swift
//  noteTakingApp
//
//  Created by akbar  Rizvi on 1/20/19.
//  Copyright © 2019 akbar  Rizvi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    

    

    @IBOutlet weak var table: UITableView!
   
    var data:[String] =  []
    var fileURL:URL!
    var selectedRow:Int = -1
    var newRowText:String = ""
    
   
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        self.title = "Notes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        let baseURl = try!FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        fileURL = baseURl.appendingPathComponent("notes.text")
        
        
        
        load()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedRow == -1 {
            return
        }
        data[selectedRow] = newRowText
        if newRowText == "" {
            data.remove(at:selectedRow)
        }
        table.reloadData()
        save()
    }
    @objc func addNote() {
        if table.isEditing {
            return
        }
        let name:String = ""
        data.insert(name, at: 0)
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
       table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
       
         self.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row
        )
        table.deleteRows(at: [indexPath], with: .fade)
        save()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.performSegue(withIdentifier: "detail", sender: nil)
    }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
        let detailView:detalViewController = segue.destination as! detalViewController
        selectedRow = table.indexPathForSelectedRow!.row
            
            detailView.masterView = self
            detailView.setText(t: data[selectedRow])
    }
    func save() {
        // UserDefaults.standard.set(data, forKey: "notes")
       let a = NSArray(array: data)
        do {
            try a.write(to: fileURL)
        } catch  {
            print("Error writing File")
        }
        
    }
    func load() {
        if let loadedData:[String] = NSArray(contentsOf: fileURL) as? [String]{
            data = loadedData
            table.reloadData()
        }
    }
    
    }

