//
//  PopupDismissViewController.swift
//  Catonomicon
//
//  Created by Gustavo Lemos on 20/08/20.
//  Copyright © 2020 Gustavo Lemos. All rights reserved.
//

import UIKit



class PopupDismissViewController: UIViewController {
let badURL = URL(string: "https://cdn2.thecatapi.com/images/cv7.jpg")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picReqURL = "https://api.thecatapi.com/v1/images/search?format=json&mime_types=png,jpg"
        let gifReqURL = "https://api.thecatapi.com/v1/images/search?format=json&api_key=e4072b66-bbdd-45ad-b3e1-2064d37e606d&&mime_types=gif"
        let testURL = "https://api.sunrise-sunset.org/json?date=2020-01-01&lat=-74.0060&lng=40.7128&formatted=0"
        let cfURL = "https://catfact.ninja/fact?max_length=140"
        //let factReqURL =\
        //let badURL = URL(string: "https://cdn2.thecatapi.com/images/cv7.jpg")
        getData(from: gifReqURL)
        //loadPic.loadPic(url: badURL!)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var loadPic: UIImageView!
    
    private func getData(from url: String){
        print("getData called.")
        let task = URLSession.shared.dataTask(with: URL(string:url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print ("Error loading data.")
                return
            }
            //Decode dos dados
            var result: [PicResp]?
            do {
                print("Decoding API information.")
                result = try JSONDecoder().decode([PicResp].self, from: data) //Morre nessa linha
                
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
            
            guard let json = result?[0] else {
                return
            }

            var catPic = URL(string: json.url)
            self.loadPic.loadPicFunc(url: catPic!)
            })
            task.resume()
    }
    
    //func getPic()
    @IBAction func dismissPopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   

  
    
    /*struct Resp: Codable {
        let results: PicResp
        //let status: String?
    }*/
    struct PicResp: Codable {
        //let sunrise: String?
        //let fact: String?
        let breeds: [String]
        let id: String
        let url: String
        let width: Int
        let height: Int

    }
    

    /*
     
     "breeds":[]
     "id":"MTkxMDc1MA"
     "url":"https://cdn2.thecatapi.com/images/MTkxMDc1MA.gif"
     "width":265
     "height":300
     
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension UIImageView {
    func loadPicFunc(url: URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data:data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
        
    }
}
