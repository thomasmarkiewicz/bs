use crate::AppState;
use actix_web::{web, Error, HttpResponse};
use futures::future::Future;
use juniper::http::graphiql::graphiql_source;
use juniper::http::GraphQLRequest;

fn graphql(
    state: web::Data<AppState>,
    data: web::Json<GraphQLRequest>,
) -> impl Future<Item = HttpResponse, Error = Error> {
    web::block(move || {
        let res = data.execute(&state.schema, &state.context);
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

pub fn configure(cfg: &mut web::ServiceConfig) {
    cfg.service(web::resource("/graphql").route(web::post().to_async(graphql))) // TODO: update nginx to expose `/graphql`
        .service(web::resource("/graphiql").route(web::get().to(graphiql))); // TODO: update nginx to expose `/graphiql`
}
