class PlatformProductTransition < ApplicationRecord
  include Statesman::Adapters::ActiveRecordTransition

  # If your transition table doesn't have the default `updated_at` timestamp column,
  # you'll need to configure the `updated_timestamp_column` option, setting it to
  # another column name (e.g. `:updated_on`) or `nil`.
  #
  # self.updated_timestamp_column = :updated_on
  # self.updated_timestamp_column = nil

  belongs_to :platform_product, inverse_of: :platform_product_transitions

  after_destroy :update_most_recent, if: :most_recent?

  private

  def update_most_recent
    last_transition = platform_product.platform_product_transitions.order(:sort_key).last
    return unless last_transition.present?
    last_transition.update_column(:most_recent, true)
  end
end
