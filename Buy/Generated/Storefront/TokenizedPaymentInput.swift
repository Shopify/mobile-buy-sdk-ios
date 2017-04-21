// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class TokenizedPaymentInput {
		open var amount: Decimal

		open var idempotencyKey: String

		open var billingAddress: MailingAddressInput

		open var type: String

		open var paymentData: String

		open var test: Bool?

		open var identifier: String?

		public init(
			amount: Decimal,

			idempotencyKey: String,

			billingAddress: MailingAddressInput,

			type: String,

			paymentData: String,

			test: Bool? = nil,

			identifier: String? = nil
		) {
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

			fields.append("amount:\(GraphQL.quoteString(input: "\(String(describing: amount))"))")

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
