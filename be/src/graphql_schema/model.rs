use crate::schema::members;

#[derive(Queryable)]
pub struct Member {
    id: i32,
    name: String,
    knockouts: i32,
    team_id: i32,
}

#[juniper::object(description = "A member of a team")]
impl Member {
    pub fn id(&self) -> i32 {
        self.id
    }
    pub fn name(&self) -> &str {
        self.name.as_str()
    }
    pub fn knockouts(&self) -> i32 {
        self.knockouts
    }
    pub fn team_id(&self) -> i32 {
        self.team_id
    }
}

// Mutation Inputs

#[derive(juniper::GraphQLInputObject, Insertable)]
#[table_name = "members"]
pub struct MemberInput {
    pub name: String,
    pub knockouts: i32,
    pub team_id: i32,
}
