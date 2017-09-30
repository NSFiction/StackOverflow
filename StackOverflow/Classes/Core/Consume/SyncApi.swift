import RxSwift

final class SyncApi: Synchronizing {

    private let service: Service

    init(service: Service) {
        self.service = service
    }

    func sync(through endPoint: URL) -> Observable<[String:AnyObject]> {
        return service.request(through: endPoint)
    }

}
