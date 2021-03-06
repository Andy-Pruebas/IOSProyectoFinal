//
//  ImagenViewController.swift
//  Snapchat
//
//  Created by mbtec22 on 7/9/20.
//  Copyright © 2020 Tecsup. All rights reserved.
//

import UIKit
import Firebase

class ImagenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descripcionTextField: UITextField!
    
    @IBOutlet weak var elegirContactoBoton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func elegirContactoTapped(_ sender: Any) {
        elegirContactoBoton.isEnabled = false
        let imagenesFolder = Storage.storage().reference().child("imagenes")
        let imagenData = imageView.image!.pngData()!
        
        imagenesFolder.child("\(NSUUID().uuidString).png").putData(imagenData, metadata: nil, completion:{(metadata, error) in
            print("Intentando subir la imagen")
            if error != nil {
                print("Ocurrió un error: \(String(describing: error))")
            } else {
                self.performSegue(withIdentifier: "seleccionarContactoSegue", sender: nil)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let imagenesFolder = Storage.storage().reference().child("imagenes")
        let imagenData = imageView.image!.pngData()!
        
        imagenesFolder.child("imagenes.png").putData(imagenData, metadata: nil, completion: {(metadata, error) in
            print("Intentando subir la imagen")
            if(error != nil) {
                print("Ocurrió un error: \(String(describing: error))")
            }
        })
    }
}
