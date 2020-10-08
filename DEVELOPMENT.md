# DEVELOPMENT

The tech stack involved to get everything running locally includes:

- [nginx](https://www.nginx.com/) proxy (serves content on localhost:3050)
- [Postgres](https://www.postgresql.org/) database (related: [pgAdmin](https://www.pgadmin.org/))
- [LDAP]() for user account directory services
- [Redis]() for in-memory cache of user/tokens
- [be] Body Sculpting Back-End app
- [webapp] Body Sculpting Front-End app for creating and managing user accounts

The `be` is a GraphQL server using [Juniper](http://www.juniper.com) as the GraphQL library and [Actix]() as the underlying HTTP server.

Make sure to install [docker](https://docs.docker.com/v17.12/install/) and [docker-compose](https://docs.docker.com/compose/install/) then bring up your development environment with:

```
sudo docker-compose up --build
```

This will crunch a while so be patient. It downloads and installs the database, servers, etc. into docker components of your local machine.

To shut down just press `Ctrl-C`.

## Useful URLs

- [GraphiQL](http://localhost:4000/graphiql) exposed by the `be` app
