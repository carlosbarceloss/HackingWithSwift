//
//  DetailsViewController.swift
//  Challenge1
//
//  Created by Carlos Barcelos on 07/06/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let imageToShare = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("Imagem não encontrada!")
            return
        }
        guard let imageTitle = flagTitle else {
            print("Não foi possível recuperar o título da imagem!")
            return
        }
        let vc = UIActivityViewController(activityItems: [imageToShare, imageTitle], applicationActivities: [])
        present(vc, animated: true)
    }
    
    var selectedFlag: String?
    var flagTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = flagTitle
        navigationItem.largeTitleDisplayMode = .never
        
        if let flagToLoad = selectedFlag {
            imageView.image = UIImage(named: flagToLoad)
            imageView.layer.borderWidth = 1.5
            imageView.layer.borderColor = UIColor.lightGray.cgColor
        }
        
    }
    
    

}
