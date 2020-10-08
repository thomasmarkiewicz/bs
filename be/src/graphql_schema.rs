mod model;
mod mutation;
mod query;

use juniper::RootNode;

pub struct QueryRoot;
pub struct MutationRoot;

pub type Schema = RootNode<'static, QueryRoot, MutationRoot>;

pub fn create_schema() -> Schema {
    Schema::new(QueryRoot {}, MutationRoot {})
}
