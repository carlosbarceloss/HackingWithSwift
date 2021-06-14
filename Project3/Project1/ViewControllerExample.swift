//
//  ViewControllerExample.swift
//  Project1
//
//  Created by Carlos Barcelos on 05/06/21.
//

/*
import UIKit

class ViewController: UIViewController { // "Quero criar uma nova tela contendo dados chamada 'ViewController', que herda de 'UIViewController'". Quando um tipo de dados inicia com "UI", significa que provém do UIKit. "UIViewController" é um tipo tela padrão da Apple, que é vazio e branco por padrão.

    var pictures = [String]()
    
    override func viewDidLoad() { // Sobrescreve o método "viewDidLoad" (UIViewController.viewDidLoad()), que é chamado quando a tela foi carregada e está pronta para ser customizada.
        
        super.viewDidLoad() // Executa o método "viewDidLoad()" da classe superior antes de executar a nossa sobrescrição.
        
        let fm = FileManager.default // Declara a constante "fm" e atribui o valor retornado pelo "FileManager.default, um tipo de dado que permite trabalhar com o sistemas de arquivos. Nesse caso, o usaremos para procurar por arquivos.
        
        let path = Bundle.main.resourcePath! // Declara a constante "path" que aponta o caminho dos recursos do nosso app. "Bundle" é um diretório contendo nosso programa compilado e todos seus recursos. (Essa linha diz: "Diga-me onde eu posso encontrar todas aquelas imagens que eu adicionei no meu aplicativo!")
        
        let items = try! fm.contentsOfDirectory(atPath: path) // Declara a constante "items" que aponta para para os conteúdos de um diretório em um caminho. Qual caminho? - O caminho que foi retornado pela linha anterior (constante path).
        
        for item in items {
            if item.hasPrefix("nssl") {
                // Para cada "item" dentro da constante "items", testa se tem o prefixo "nssl". Se sim, executa o código a seguir. (Nesse caso, todas as imagens do nosso App tem o prefixo "nssl".
                pictures.append(item)
            }
        }
    }
}
*/
