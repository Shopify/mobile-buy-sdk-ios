// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CreditCardPaymentInput {
		open var amount: Decimal

		open var idempotencyKey: String

		open var billingAddress: MailingAddressInput

		open var vaultId: String

		open var test: Bool?

		public init(
			amount: Decimal,

			idempotencyKey: String,

			billingAddress: MailingAddressInput,

			vaultId: String,

			test: Bool? = nil
		) {
			self.amount = amount

			self.idempotencyKey = idempotencyKey

			self.billingAddress = billingAddress

			self.vaultId = vaultId

			self.test = test
		}

		func serialize() -> String {
			var fields: [String] = []

			fields.append("amount:\(GraphQL.quoteString(input: "\(String(describing: amount))"))")

			fields.append("idempotencyKey:\(GraphQL.quoteString(input: idempotencyKey))")

			fields.append("billingAddress:\(billingAddress.serialize())")

			fields.append("vaultId:\(GraphQL.quoteString(input: vaultId))")

			if let test = test {
				fields.append("test:\(test)")
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
