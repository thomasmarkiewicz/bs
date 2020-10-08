mod graphql_schema;

mod routes;
mod schema;

#[macro_use]
extern crate diesel;

use actix_web::{middleware, App, HttpServer};
use diesel::prelude::*;
use diesel::r2d2::{self, ConnectionManager};
use std;

use graphql_schema::{create_schema, Schema};

type Pool = r2d2::Pool<ConnectionManager<PgConnection>>;

pub struct Webapp {
    port: u16,
}

//---- context

pub struct Context {
    pub pool: Pool,
}

// To make our context usable by Juniper, we have to implement a marker trait.
impl juniper::Context for Context {}

struct AppState {
    context: Context, // it's an Arc
    schema: std::sync::Arc<Schema>,
}

impl Webapp {
    pub fn new(port: u16) -> Self {
        Webapp { port }
    }

    pub fn run(&self, database_url: String) -> std::io::Result<()> {
        let manager = ConnectionManager::<PgConnection>::new(database_url);
        let pool = r2d2::Pool::builder()
            .build(manager)
            .expect("Failed to create pool.");
        let schema = std::sync::Arc::new(create_schema());
        println!("Starting http server: 127.0.0.1:{}", self.port);
        HttpServer::new(move || {
            App::new()
                .data(AppState {
                    context: Context { pool: pool.clone() },
                    schema: schema.clone(),
                })
                .wrap(middleware::Logger::default())
                .configure(routes::configure)
        })
        .bind(("127.0.0.1", self.port))?
        //.workers(8)
        .run()
    }
}
