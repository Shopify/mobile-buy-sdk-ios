// Generated from graphql_swift_gen gem

open class ApiSchema {
	open static func buildQuery(_ subfields: (QueryRootQuery) -> Void) -> QueryRootQuery {
		let root = QueryRootQuery()
		subfields(root)
		return root
	}

	open static func buildMutation(_ subfields: (MutationQuery) -> Void) -> MutationQuery {
		let root = MutationQuery()
		subfields(root)
		return root
	}
}
