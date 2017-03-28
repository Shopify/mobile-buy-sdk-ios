// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CustomerUpdateInput {
		open var clientMutationId: String?

		open var accessToken: String

		open var firstName: String?

		open var lastName: String?

		open var email: String?

		open var password: String?

		open var acceptsMarketing: Bool?

		public init(
			accessToken: String,

			clientMutationId: String? = nil,

			firstName: String? = nil,

			lastName: String? = nil,

			email: String? = nil,

			password: String? = nil,

			acceptsMarketing: Bool? = nil
		) {
			self.clientMutationId = clientMutationId

			self.accessToken = accessToken

			self.firstName = firstName

			self.lastName = lastName

			self.email = email

			self.password = password

			self.acceptsMarketing = acceptsMarketing
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("accessToken:\(GraphQL.quoteString(input: accessToken))")

			if let firstName = firstName {
				fields.append("firstName:\(GraphQL.quoteString(input: firstName))")
			}

			if let lastName = lastName {
				fields.append("lastName:\(GraphQL.quoteString(input: lastName))")
			}

			if let email = email {
				fields.append("email:\(GraphQL.quoteString(input: email))")
			}

			if let password = password {
				fields.append("password:\(GraphQL.quoteString(input: password))")
			}

			if let acceptsMarketing = acceptsMarketing {
				fields.append("acceptsMarketing:\(acceptsMarketing)")
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
