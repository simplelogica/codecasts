defimpl Canada.Can, for: User do
  def can?(%User{id: user_id}, action, %Post{user_id: user_id})
    when action in [:update, :read, :destroy], do: true

  def can?(%User{admin: admin}, action, _)
    when action in [:update, :read, :destroy], do: admin

  # By default, only read
  def can?(%User{}, :read, Post) do: true
  def can?(%User{}, _, Post) do: false
end
