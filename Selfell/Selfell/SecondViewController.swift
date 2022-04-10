//
//  SecondViewController.swift
//  Selfell
//
//  Created by Hasan Tekbaş on 1.03.2022.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var btclabel: UILabel!
    @IBOutlet weak var etclabel: UILabel!
    @IBOutlet weak var dollarlabel: UILabel!
    @IBOutlet weak var lastuplabel: UILabel!
    let urlString = "https://api.coingecko.com/api/v3/exchange_rates"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()

        let timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func CoinInfo(_ sender: Any) {
        performSegue(withIdentifier: "toCoinView", sender: nil)
    }
    @objc func refreshData() -> Void{
        fetchData()
    }
    func fetchData(){
        let url = URL(string: urlString)
        let defaultSession = URLSession(configuration: .default)
        let dataTask = defaultSession.dataTask(with: url!) {(data: Data?, response: URLResponse?, error: Error?) in
            
            if(error != nil){
                print(error!)
                return
            }
            do{
                let json = try JSONDecoder().decode(Rates.self, from: data!)
                self.setPrices(currency: json.rates)
            }
            catch{
                print(error)
                return
            }
        }
        dataTask.resume()
        
    }
    func setPrices(currency: Currency)
    {
        DispatchQueue.main.async {
            self.btclabel.text = self.formatPrice(currency.btc)
            self.etclabel.text = self.formatPrice(currency.eth)
            self.dollarlabel.text = self.formatPrice(currency.usd)
            self.lastuplabel.text = self.formatDate(date: Date())
        }
    }
    func formatPrice(_ price: Price) -> String{
        return String(format: "%@ %.4f", price.unit, price.value)
    }
    
    func formatDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM y HH:mm:ss"
        return formatter.string(from: date)
    }
    struct Rates: Codable {
        let rates : Currency
    }
    
    struct Currency: Codable {
        let btc: Price
        let eth: Price
        let usd: Price
    }
    
    struct Price: Codable {
        let name: String
        let unit: String
        let value: Float
        let type: String
    }
    
    @IBAction func setting(_ sender: Any) {
        performSegue(withIdentifier: "toSettingView", sender: nil)

    }
  
    @IBAction func exit(_ sender: Any) {
        performSegue(withIdentifier: "toSettingView", sender: nil)
    }
}
