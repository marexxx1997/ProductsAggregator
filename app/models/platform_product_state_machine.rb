class PlatformProductStateMachine
    include Statesman::Machine
  
    # Define all possible states
    state :initialized, initial: :true
    state :in_progress
    state :located
    state :approved
    state :error
  
    # Define transition rules
    transition from: :initialized, to: :in_progress
    transition from: :in_progress, to: [:located, :error]
    transition from: :located, to: :approved
  end