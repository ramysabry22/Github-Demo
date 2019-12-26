
import UIKit
import RealmSwift



class LocalStorageManager: NSObject {
    
    
    static func select<T: Object>(realmObjectType: Object.Type, realmObject: T, completion: @escaping(_ selectedData: [T]?) -> () )
    {
        do {
            let realm = try Realm()
            let data = realm.objects(realmObjectType)
            if data.count > 0 {
                var selectedData = [T]()
                data.forEach { (item) in
                    if let castedItem = item as? T {
                        selectedData.append(castedItem)
                    }
                }
                completion(selectedData)
            }
            else {
                completion(nil)
            }
        } catch(_)
        {
            completion(nil)
        }
    }
    
    
    static func insert<T: Object>(realmObject: [T], completion: @escaping(_ Inserted: Bool) -> () )
    {
        do {
            let realm = try Realm()
              try realm.write {
                realm.add(realmObject)
              }
                completion(true)
        } catch(_)
        {
            completion(false)
        }
    }
    
    
    
    static func delete(realmObjectType: Object.Type, completion: @escaping(_ Deleted: Bool) -> () )
    {
        do {
            let realm = try Realm()
            let data = realm.objects(realmObjectType.self)
            if data.count > 0 {
                try realm.write {
                    realm.delete(data)
                }
            }
            completion(true)
        } catch(_)
        {
            completion(false)
        }
    }
    
    
    
    static func update<T: Object>(realmObjectType: Object.Type, realmObject: [T], completion: @escaping(_ Updated: Bool) -> () )
    {
        do {
            let realm = try Realm()
            let data = realm.objects(realmObjectType)
            if data.count > 0 {
                try realm.write {
                    realm.add(realmObject, update: true)
                }
                completion(true)
            }
            else {
                try realm.write {
                    realm.add(realmObject)
                }
                completion(true)
            }
        } catch(_)
        {
            completion(false)
        }
    }
    
    
}
