class PlatformProduct < ApplicationRecord
  # include Statesman::Adapters::ActiveRecordQueries[transition_class: PlatformProductTransition, initial_state: :initialized]

    belongs_to :product
    belongs_to :platform

    has_many :platform_product_transitions


  def state_machine
    @state_machine ||= PlatformProductStateMachine.new(
      self,
      transition_class: PlatformProductTransition,
      association_name: :platform_product_transitions
    )
  end

  def self.transition_class
    PlatformProductTransition
  end

  def self.initial_state
    :initialized
  end

  private_class_method :initial_state

  delegate :allowed_transitions, :history, :current_state, :transition_to, :transition_to!, to: :state_machine

    # validates :url, presence: true
    # state :initial, initial: true
    # state :in_progress
    # state :approved
    # state :error
    # state_machine initial: :initialized do
    #   transition from: :initialized, to: :in_progress
    #   transition from: :initialized, to: :error
    #   transition from: :in_progress, to: :approved
    # end  

    # has_many :platform_product_transitions, class_name: 'PlatformProductTransition', autosave: false

    # def self.transition_class
    #   PlatformProductTransition
    # end

    # def self.initial_state
    #   :initialized
    # end

    # def self.transition_name
    #   :platform_product_transition
    # end
  end
  