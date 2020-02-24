//
//  SearchDetailViewController.swift
//  itunesTest
//
//  Created by Rodrigo Astorga on 23-02-20.
//  Copyright (c) 2020 Rodrigo Astorga. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//
import UIKit
import Kingfisher
import AVFoundation

protocol SearchDetailDisplayLogic: class
{
    func displayDetailSearch(viewModel: SearchDetail.FetchDetail.ViewModel)
}

class SearchDetailViewController: UIViewController, SearchDetailDisplayLogic
{
    @IBOutlet weak var tableView: UITableView!
    
    let player = AVQueuePlayer()
    var urlPreview: URL?
    var interactor: SearchDetailBusinessLogic?
    var router: (NSObjectProtocol & SearchDetailRoutingLogic & SearchDetailDataPassing)?
    var media: MediaResult!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = SearchDetailInteractor()
        let presenter = SearchDetailPresenter()
        let router = SearchDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        doSomething()
    }
    
    // MARK: Do something

    func doSomething()
    {
        self.title = router?.dataStore?.media?.trackName ?? ""
        self.media = router?.dataStore?.media

        //    let request = SearchDetail.FetchDetail.Request()
        //    interactor?.doSomething(request: request)
    }
    
    func displayDetailSearch(viewModel: SearchDetail.FetchDetail.ViewModel)
    {
//        self.title = viewModel.title
//        self.navigationItem.title = viewModel.title
    }
}

extension SearchDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellImage = tableView.dequeueReusableCell(withIdentifier: "cellImage", for: indexPath) as! ArtworkTableViewCell
        let cellDetail = tableView.dequeueReusableCell(withIdentifier: "cellDetail", for: indexPath) as! DetailArtistTableViewCell
        let cellBand = tableView.dequeueReusableCell(withIdentifier: "cellTitle", for: indexPath)
        let cellNameSong = tableView.dequeueReusableCell(withIdentifier: "cellNameSong", for: indexPath)
        let cellWebView = tableView.dequeueReusableCell(withIdentifier: "cellWebView", for: indexPath) as! WebViewTableViewCell
        
        if indexPath.row == 0 {
            cellImage.viewModel = ArtworkTableViewCell.ViewModel(artworkURL: media.artworkUrl100!)
            return cellImage
        } else if indexPath.row == 1 {
            cellDetail.viewModel = DetailArtistTableViewCell.ViewModel(trackName: media.trackName ?? "", artistName: media.artistName ?? "")
            return cellDetail
        } else if indexPath.row == 2 {
            return cellBand
        } else {
            cellWebView.viewModel = WebViewTableViewCell.ViewModel(url: media.trackViewUrl!)
            return cellWebView
        }
    }
}