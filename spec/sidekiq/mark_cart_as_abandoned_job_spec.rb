require 'rails_helper'

RSpec.describe MarkCartAsAbandonedJob, type: :job do
  let!(:cart_1) { create(:shopping_cart, last_interaction_at: 4.hours.ago) }
  let!(:cart_2) { create(:shopping_cart, last_interaction_at: 1.hours.ago) }
  let!(:cart_3) { create(:shopping_cart, last_interaction_at: 5.hours.ago) }

  describe "#perform" do
    subject { described_class.new }

    it "marks only abandoned cart" do
      subject.perform

      expect(cart_1.reload.abandoned?).to be_truthy
      expect(cart_2.reload.abandoned?).to be_falsey
      expect(cart_3.reload.abandoned?).to be_truthy
    end
  end
end
