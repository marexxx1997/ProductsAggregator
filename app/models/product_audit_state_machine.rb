class ProductAuditStateMachine
    include Statesman::Machine
  
    # Define all possible states
    state :initialized, initial: :true
    state :processing
    state :finished
    state :error
  
    # Define transition rules
    transition from: :initialized, to: :processing
    transition from: :processing, to: [:finished, :error]
end