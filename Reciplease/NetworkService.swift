import Foundation

class NetworkService {
    init(url: String) {
        self.url = URL(string: url)!
    }
    
    var url: URL
    var networkSession = URLSession(configuration: .default)
    var task: URLSessionDataTask?
    
    enum NetworkError: Error {
        case noData, error, responseNot200, incorectUrl, emptyResponse, emptyBookmarkResponse
    }
    
    func getData(callback: @escaping(Result<Data, NetworkError>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        task = networkSession.dataTask(with: request) { (data, response, error) -> Void in
            DispatchQueue.main.async {
                guard let data = data else {
                    callback(.failure(.noData))
                    return
                }

                guard error == nil else {
                    callback(.failure(.error))
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(.responseNot200))
                    return
                }

                callback(.success(data))
            }

        }
        task?.resume()
    }
    
    func getData(url: URL, callback: @escaping (Result<Data, NetworkError>) -> Void) {
        self.url = url
        
        getData { result in
            callback(result)
        }
    }
}
