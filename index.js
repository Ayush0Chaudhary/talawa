const { ApolloServer, gql } = require("apollo-server");
const Query = require("./resolvers/Query");
const Mutation = require("./resolvers/Mutation");
const typeDefs = require("./schema.graphql");
const isAuth = require("./middleware/is-auth");
const User = require("./resolvers/User");
const express = require("express");
const connect = require("./db.js");
const Organization = require("./resolvers/Organization")
const app = express();

const resolvers = {
  Query,
  Mutation,
  User,
  Organization
};

const server = new ApolloServer({
  typeDefs,
  resolvers,
  context: ({ req }) => {
    return isAuth(req);
  },
});

connect
  .then(() => {
    server.listen({ port: process.env.PORT || 4000 }).then(({ url }) => {
  console.log(`🚀 Server ready at ${url}`);
});
  })
  .catch((e) => console.log(e));
