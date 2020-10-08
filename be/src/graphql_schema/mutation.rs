use super::model::{Member, MemberInput};
use super::MutationRoot;
use crate::schema::members;
use crate::Context;
use diesel::prelude::*;

#[juniper::object(Context = Context)]
impl MutationRoot {
    fn create_member(context: &Context, data: MemberInput) -> Member {
        let conn = context.pool.get().unwrap();
        diesel::insert_into(members::table)
            .values(&data)
            .get_result(&conn)
            .expect("Error saving new member")
    }
}
