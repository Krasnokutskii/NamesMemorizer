//
//  ViewController.swift
//  Project10
//
//  Created by Ярослав on 4/3/21.
//

import UIKit

class ViewController: UICollectionViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
    }
    
    @objc func addNewPerson(){
        
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
            print("camera is not available at this moment")
        }
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else{
            fatalError("unable to deque PERSON CELL")
        }
        let person = people[indexPath.item]
        cell.name.text = person.name
        let path = getDocumentDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        return cell
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString

        let imagePath = getDocumentDirectory().appendingPathComponent(imageName)

        if let jpagData = image.jpegData(compressionQuality: 0.8){
            try? jpagData.write(to: imagePath)
        }
        let person = Person(image: imageName, name: "unnown")
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true)
        
    }
    func getDocumentDirectory()->URL{
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return path[0]
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let ac = UIAlertController(title: "Rename or delite", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "rename", style: .default, handler: {  [weak self, weak ac] (UIAlertAction) in
            guard let newName = ac?.textFields?[0].text else { return }
            person.name = newName
            self?.collectionView.reloadData()
        }))
        ac.addAction(UIAlertAction(title: "delite", style: .default, handler: {  [weak self] action in
            self?.people.remove(at: indexPath.item)
            collectionView.reloadData()
        }))
        
//        ac.addAction(UIAlertAction(title: "OK" , style: .default){
//            [weak self, weak ac] action in
//            guard let newName = ac?.textFields?[0].text else { return }
//            person.name = newName
//            self?.collectionView.reloadData()
//        })

        ac.addAction(UIAlertAction(title: "cance", style: .cancel))
        present(ac, animated: true)
    }

}

