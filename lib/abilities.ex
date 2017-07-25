alias Elixon.{User, Notification}
defimpl Canada.Can, for: User do
  #    def can?(%User{id: user_id}, action, %Post{user_id: user_id})
  #      when action in [:update, :read, :destroy, :touch], do: true
  #
  #    def can?(%User{admin: admin}, action, _)
  #      when action in [:update, :read, :destroy, :touch], do: admin
  #
  #  def can?(%User{}, :create, Post), do: true
    def can?(%User{}, _, Notification), do: true
    def can?(%User{}, _, _), do: true
end
