// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CheckoutCompleteWithTokenizedPaymentInput {
		open var clientMutationId: String?

		open var checkoutId: GraphQL.ID

		open var amount: NSDecimalNumber

		open var idempotencyKey: String

		open var billingAddress: MailingAddressInput

		open var type: String

		open var paymentData: String

		open var test: Bool?

		open var identifier: String?

		public init(
			checkoutId: GraphQL.ID,

			amount: NSDecimalNumber,

			idempotencyKey: String,

			billingAddress: MailingAddressInput,

			type: String,

			paymentData: String,

			clientMutationId: String? = nil,

			test: Bool? = nil,

			identifier: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.checkoutId = checkoutId

			self.amount = amount

			self.idempotencyKey = idempotencyKey

			self.billingAddress = billingAddress

			self.type = type

			self.paymentData = paymentData

			self.test = test

			self.identifier = identifier
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			fields.append("amount:\(GraphQL.quoteString(input: "\(amount.description(withLocale: GraphQL.posixLocale))"))")

			fields.append("idempotencyKey:\(GraphQL.quoteString(input: idempotencyKey))")

			fields.append("billingAddress:\(billingAddress.serialize())")

			fields.append("type:\(GraphQL.quoteString(input: type))")

			fields.append("paymentData:\(GraphQL.quoteString(input: paymentData))")

			if let test = test {
				fields.append("test:\(test)")
			}

			if let identifier = identifier {
				fields.append("identifier:\(GraphQL.quoteString(input: identifier))")
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
