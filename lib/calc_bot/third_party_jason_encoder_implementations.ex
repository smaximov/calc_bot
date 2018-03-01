require Protocol

Protocol.derive(Jason.Encoder, ApolloTracing.Schema)
Protocol.derive(Jason.Encoder, ApolloTracing.Schema.Execution)
