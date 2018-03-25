// MARK: - Image Rect helpers

extension UIImageView {

    func getImageRect() -> CGRect? {
        guard let image = self.image else { return nil }

        let imageViewSize = self.frame.size
        let imageSize = image.size

        let scaleW = imageViewSize.width / imageSize.width
        let scaleH = imageViewSize.height / imageSize.height
        let aspect = fmin(scaleW, scaleH)

        var imageRect: CGRect
        if contentMode == .scaleAspectFill {
            imageRect = CGRect(x: 0, y: 0, width: imageViewSize.width, height: imageViewSize.height)
        } else {
            imageRect = CGRect(x: 0, y: 0, width: imageSize.width * aspect, height: imageSize.height * aspect)
        }

        imageRect.origin.x = (imageViewSize.width - imageRect.size.width) / 2
        imageRect.origin.y = (imageViewSize.height - imageRect.size.height) / 2

        imageRect.origin.x += frame.origin.x
        imageRect.origin.y += frame.origin.y

        return imageRect
    }

    func getOriginalImageRect(forRect rect: CGRect) -> CGRect? {
        guard let image = self.image else { return nil }

        var imageRect: CGRect!
        var sRect = rect
        if contentMode == .scaleAspectFit {
            guard let rect = getImageRect() else { return nil }
            imageRect = rect
            sRect.origin.x -= imageRect.origin.x
            sRect.origin.y -= imageRect.origin.y
        } else if contentMode == .scaleAspectFill {
            imageRect = frame
            sRect.origin.x -= imageRect.origin.x
            sRect.origin.y -= imageRect.origin.y
            let imageSize = image.size
            var imageViewSize = frame.size

            let imageVerticalRatio = imageSize.height / imageSize.width
            let imageViewVerticalRatio = imageViewSize.height / imageViewSize.width
            let ratio = imageVerticalRatio / imageViewVerticalRatio

            if image.size.width < image.size.height {
                imageViewSize.height = imageViewSize.height * ratio
            } else {
                imageViewSize.width = imageViewSize.width * ratio
            }
            let heightDiff = imageViewSize.height - frame.size.height
            let widthDiff = imageViewSize.width - frame.size.width
            sRect.origin.x += widthDiff / 2
            sRect.origin.y += heightDiff / 2
            imageRect.size = imageViewSize
        } else {
            return nil
        }

        let imageSize = imageRect.size
        let originalImageSize = image.size

        let scaleHorizontal = originalImageSize.width / imageSize.width
        let scaleVertical = originalImageSize.height / imageSize.height

        let originalImageRect = CGRect(x: sRect.origin.x * scaleHorizontal, y: sRect.origin.y * scaleVertical, width: sRect.width * scaleHorizontal, height: sRect.height * scaleVertical)
        return originalImageRect
    }

}

// MARK: - Clear cache (by url) for alamofire image framework

extension UIImageView {

    static func clearCache(for url: URL) {
        let imageDownloader = UIImageView.af_sharedImageDownloader
        let urlRequest = URLRequest(url: url)
        //Clear from in-memory cache
        imageDownloader.imageCache?.removeImage(for: urlRequest, withIdentifier: nil)
        //Clear from on-disk cache
        imageDownloader.sessionManager.session.configuration.urlCache?.removeCachedResponse(for: urlRequest)
    }

}
