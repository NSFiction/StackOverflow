import RxSwift

final class TagSyncApi: TagSynchronizing {

    private let service: Service

    init(service: Service) {
        self.service = service
    }

    func sync(through endPoint: URL) -> Observable<[String:AnyObject]> {
        return service.request(through: endPoint)
    }

}
