# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
   field :create_user, mutation: Mutations::CreateUser
   field :login, mutation: Mutations::Login
   field :delete_post, mutation: Mutations::DeletePost
   field :create_post, mutation: Mutations::CreatePost
   field :edit_post, mutation: Mutations::EditPost
  end
end
