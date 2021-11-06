// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Favorites.swift instead.

import Foundation
import CoreData

public enum FavoritesAttributes: String {
    case id = "id"
    case imageUrl = "imageUrl"
    case modified = "modified"
    case name = "name"
    case notes = "notes"
    case resourceURI = "resourceURI"
    case thumbnailUrl = "thumbnailUrl"
}

open class _Favorites: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Favorites"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Favorites.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var id: String

    @NSManaged open
    var imageUrl: String?

    @NSManaged open
    var modified: Date?

    @NSManaged open
    var name: String

    @NSManaged open
    var notes: String?

    @NSManaged open
    var resourceURI: String?

    @NSManaged open
    var thumbnailUrl: String?

    // MARK: - Relationships

}

