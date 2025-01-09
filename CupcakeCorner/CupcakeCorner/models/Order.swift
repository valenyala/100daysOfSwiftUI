import SwiftUI

@Observable
class Order: Codable {

    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false

    var cost: Decimal {
        var cost = Decimal(quantity) * 2

        cost += Decimal(type) / 2

        if extraFrosting {
            cost += Decimal(quantity)
        }

        if addSprinkles {
            cost += Decimal(quantity) / 2
        }

        return cost
    }

    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
    }

    var name = "" {
        didSet {
            UserDefaults.standard.set(name, forKey: "name")
        }
    }
    var streetAddress = "" {
        didSet {
            UserDefaults.standard.set(streetAddress, forKey: "streetAddress")
        }
    }
    var city = "" {
        didSet {
            UserDefaults.standard.set(city, forKey: "city")
        }
    }
    var zip = "" {
        didSet {
            UserDefaults.standard.set(zip, forKey: "zip")
        }
    }
    init() {
        name = UserDefaults.standard.string(forKey: "name") ?? ""
        streetAddress = UserDefaults.standard.string(forKey: "streetAddress") ?? ""
        city = UserDefaults.standard.string(forKey: "city") ?? ""
        zip = UserDefaults.standard.string(forKey: "zip") ?? ""
    }

    var hasValidAddress: Bool {
        return !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
