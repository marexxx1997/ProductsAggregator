class ProductAudit < ApplicationRecord
    belongs_to :product
    belongs_to :scan

    has_many :product_audit_transitions


  def state_machine
    @state_machine ||= ProductAuditStateMachine.new(
      self,
      transition_class: ProductAuditTransition,
      association_name: :product_audit_transitions
    )
  end

  def self.transition_class
    ProductAuditTransition
  end

  def self.initial_state
    :initialized
  end

  private_class_method :initial_state

  delegate :allowed_transitions, :history, :current_state, :transition_to, :transition_to!, to: :state_machine
end