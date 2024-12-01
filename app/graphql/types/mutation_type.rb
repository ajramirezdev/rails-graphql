# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
   field :create_user, mutation: Mutations::CreateUser
   field :login, mutation: Mutations::Login
   field :delete_user, mutation: Mutations::DeleteUser
   field :delete_post, mutation: Mutations::DeletePost
   field :create_post, mutation: Mutations::CreatePost
   field :edit_post, mutation: Mutations::EditPost
   field :edit_me, mutation: Mutations::EditMe
   field :edit_user, mutation: Mutations::EditUser
   field :me_like, mutation: Mutations::MeLike
   field :me_delete_like, mutation: Mutations::MeDeleteLike
  end
end
