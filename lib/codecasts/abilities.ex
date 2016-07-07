defimpl Canada.Can, for: Codecasts.User do
  def can?(%Codecasts.User{id: user_id}, action, %Codecasts.Event{user_id: user_id})
    when action in [:edit, :update, :show, :destroy], do: true

  def can?(%Codecasts.User{admin: admin}, action, Codecasts.Event)
    when action in [:edit, :update, :show, :destroy], do: admin

  # By default, only read
  def can?(Codecasts.User, :show, Codecasts.Event), do: true
  def can?(Codecasts.User, _, Codecasts.Event), do: false
end
