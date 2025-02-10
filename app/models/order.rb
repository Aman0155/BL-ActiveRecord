class Order < ApplicationRecord
  after_create :schedule_expiry
private

  def schedule_expiry
    ExpiresUnpaidOrdersJob.set(wait: 1.minute).perform_later(id)
  end
end
