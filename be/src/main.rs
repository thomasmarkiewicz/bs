// main.rs
use dotenv::dotenv;
use std::env;

fn main() -> std::io::Result<()> {
    dotenv().ok();
    env::set_var("RUST_LOG", "actix_web=info");
    env_logger::init();
    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    let app = be::Webapp::new(4000);
    app.run(database_url)
}

/*
#[macro_use]
extern crate diesel;
extern crate juniper;

use std::io;
use std::sync::Arc;

use actix_web::{web, App, Error, HttpResponse, HttpServer};
use futures::future::Future;
use juniper::http::graphiql::graphiql_source;
use juniper::http::GraphQLRequest;

mod graphql_schema;
mod schema;

use crate::graphql_schema::{create_schema, Schema};

fn main() -> io::Result<()> {
    let schema = std::sync::Arc::new(create_schema());
    HttpServer::new(move || {
        App::new()
            .data(schema.clone())
            .service(web::resource("/graphql").route(web::post().to_async(graphql))) // TODO: update nginx to expose `/graphql`
            .service(web::resource("/graphiql").route(web::get().to(graphiql))) // TODO: update nginx to expose `/graphiql`
    })
    .bind("localhost:4000")?
    .run()
}

fn graphql(
    st: web::Data<Arc<Schema>>,
    data: web::Json<GraphQLRequest>,
) -> impl Future<Item = HttpResponse, Error = Error> {
    web::block(move || {
        let res = data.execute(&st, &());
        Ok::<_, serde_json::error::Error>(serde_json::to_string(&res)?)
    })
    .map_err(Error::from)
    .and_then(|user| {
        Ok(HttpResponse::Ok()
            .content_type("application/json")
            .body(user))
    })
}

fn graphiql() -> HttpResponse {
    let html = graphiql_source("http://localhost:4000/graphql");
    HttpResponse::Ok()
        .content_type("text/html; charset=utf-8")
        .body(html)
}
*/
