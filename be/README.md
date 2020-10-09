## Getting Started

```sh
git clone https://github.com/clifinger/canduma.git
cd canduma
docker-compose up
cp .env.example .env
diesel setup --database-url='postgres://postgres:canduma@localhost/canduma'
diesel migration run
cargo run
```

### Generate RSA keys for JWT

In development mode you can keep the one in `/keys` folder.

```shell script
// private key
$ openssl genrsa -out rs256-4096-private.rsa 4096

// public key
$ openssl rsa -in rs256-4096-private.rsa -pubout > rs256-4096-public.pem
```

### Logging

Logging controlled by middleware::Logger [actix.rs](https://actix.rs/docs/errors/)

To enable debug logging set `RUST_LOG=debug` in `.env`
