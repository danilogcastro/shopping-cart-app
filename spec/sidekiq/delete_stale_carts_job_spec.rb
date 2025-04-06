require 'rails_helper'

RSpec.describe DeleteStaleCartsJob, type: :job do
  let!(:cart_1) { create(:shopping_cart, status: 1, last_interaction_at: 10.days.ago) }
  let!(:cart_2) { create(:shopping_cart, last_interaction_at: 1.hours.ago) }

  describe "#perform" do
    subject { described_class.new }

    it "deletes only stale cart" do
      expect { subject.perform }.to change { Cart.count }.by(-1)
    end
  end
end
