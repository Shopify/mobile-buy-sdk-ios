// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CheckoutCompleteWithCreditCardInput {
		open var clientMutationId: String?

		open var checkoutId: GraphQL.ID

		open var amount: Decimal

		open var idempotencyKey: String

		open var billingAddress: MailingAddressInput

		open var vaultId: String

		open var test: Bool?

		public init(
			checkoutId: GraphQL.ID,

			amount: Decimal,

			idempotencyKey: String,

			billingAddress: MailingAddressInput,

			vaultId: String,

			clientMutationId: String? = nil,

			test: Bool? = nil
		) {
			self.clientMutationId = clientMutationId

			self.checkoutId = checkoutId

			self.amount = amount

			self.idempotencyKey = idempotencyKey

			self.billingAddress = billingAddress

			self.vaultId = vaultId

			self.test = test
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

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
