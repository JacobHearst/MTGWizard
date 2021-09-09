//
//  ImageView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 6/21/21.
//

import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

struct AsyncImage: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image: UIImage = UIImage()

    init(url: URL) {
        imageLoader = ImageLoader(url: url)
    }

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
    }
}
