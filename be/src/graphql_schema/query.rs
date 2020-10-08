use super::model::Member;
use super::QueryRoot;
use crate::Context;
use diesel::prelude::*;

#[juniper::object(Context = Context)]
impl QueryRoot {
    fn members(context: &Context) -> Vec<Member> {
        // TODO: refactor to membersRepo
        use crate::schema::members::dsl::*;
        let conn = context.pool.get().unwrap();
        members
            .limit(100)
            .load::<Member>(&conn)
            .expect("Error loading members")
    }
}
