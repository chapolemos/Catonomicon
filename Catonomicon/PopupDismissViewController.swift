//
//  PopupDismissViewController.swift
//  Catonomicon
//
//  Created by Gustavo Lemos on 20/08/20.
//  Copyright © 2020 Gustavo Lemos. All rights reserved.
//

import UIKit

class PopupDismissViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picReqURL = "https://api.thecatapi.com/v1/images/search?format=json&mime_types=png,jpg"
        let gifReqURL = "https://api.thecatapi.com/v1/images/search?format=json&api_key=e4072b66-bbdd-45ad-b3e1-2064d37e606d&&mime_types=gif"
        let testURL = "https://api.sunrise-sunset.org/json?date=2020-01-01&lat=-74.0060&lng=40.7128&formatted=0"
        let cfURL = "https://catfact.ninja/fact?max_length=140"
        //let factReqURL =\
        getData(from: cfURL)
       
        // Do any additional setup after loading the view.
    }
    
   
    private func getData(from url: String){
        print("chamou")
        let task = URLSession.shared.dataTask(with: URL(string:url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print ("error")
                return
            }
            //Conversão dos dados
            var result: PicResp?
            do {
                print("do")
                result = try JSONDecoder().decode(PicResp.self, from: data) //Morre nessa linha
                
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
            
            guard let json = result else {
                
                return
            }
            print(json.fact)
            //print(json.results.sunrise)
           // print(json.results.width)
           // print(json.results.height)
            })
            task.resume()
    }
    @IBAction func dismissPopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    
    
    struct Resp: Codable {
        let results: PicResp
        //let status: String?
    }
    struct PicResp: Codable {
        //let sunrise: String?
        //let breeds: [String]?
        //let id: String?
        //let url: String?
        //let width: Int?
        let fact: String?
        //let height: Int?

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
