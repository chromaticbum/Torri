module StatesHelper
  def states_select_data
    State.all.collect do |state|
      [state.name, state.id]
    end
  end
end
