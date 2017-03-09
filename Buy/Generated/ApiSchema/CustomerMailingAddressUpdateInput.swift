// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class CustomerMailingAddressUpdateInput {
		open var clientMutationId: String?

		open var id: GraphQL.ID

		open var address1: String?

		open var address2: String?

		open var city: String?

		open var company: String?

		open var country: String?

		open var firstName: String?

		open var lastName: String?

		open var phone: String?

		open var province: String?

		open var zip: String?

		public init(
			id: GraphQL.ID,

			clientMutationId: String? = nil,

			address1: String? = nil,

			address2: String? = nil,

			city: String? = nil,

			company: String? = nil,

			country: String? = nil,

			firstName: String? = nil,

			lastName: String? = nil,

			phone: String? = nil,

			province: String? = nil,

			zip: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.id = id

			self.address1 = address1

			self.address2 = address2

			self.city = city

			self.company = company

			self.country = country

			self.firstName = firstName

			self.lastName = lastName

			self.phone = phone

			self.province = province

			self.zip = zip
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			if let address1 = address1 {
				fields.append("address1:\(GraphQL.quoteString(input: address1))")
			}

			if let address2 = address2 {
				fields.append("address2:\(GraphQL.quoteString(input: address2))")
			}

			if let city = city {
				fields.append("city:\(GraphQL.quoteString(input: city))")
			}

			if let company = company {
				fields.append("company:\(GraphQL.quoteString(input: company))")
			}

			if let country = country {
				fields.append("country:\(GraphQL.quoteString(input: country))")
			}

			if let firstName = firstName {
				fields.append("firstName:\(GraphQL.quoteString(input: firstName))")
			}

			if let lastName = lastName {
				fields.append("lastName:\(GraphQL.quoteString(input: lastName))")
			}

			if let phone = phone {
				fields.append("phone:\(GraphQL.quoteString(input: phone))")
			}

			if let province = province {
				fields.append("province:\(GraphQL.quoteString(input: province))")
			}

			if let zip = zip {
				fields.append("zip:\(GraphQL.quoteString(input: zip))")
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
