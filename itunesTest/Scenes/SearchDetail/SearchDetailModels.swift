//
//  SearchDetailModels.swift
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

enum SearchDetail
{
  // MARK: Use cases
  
  enum FetchDetail
  {
    struct Request
    {
    }
    struct Response
    {
        
    }
    struct ViewModel
    {
        struct DetailSearch {
            let title: String
            let bandName: String
            let albumName: String
            let artwork: URL
        }
        var detailSearch: DetailSearch
    }
  }
}