require_relative './other_business_rules'

describe 'Order processing application' do
  let(:order_builder) { OrderBuilder.new }

  context 'Payment is for a physical product' do
    it 'generates a packing slip for shipping' do
      order = order_builder.for_physical_product.build
      result = order.process

      expect(result.for_shipping).to eq(:packing_slip)
      expect(result.for_royalty).to be_nil
    end

    context 'When the payment is for a book' do
      it 'creates a duplicated packing slip for the royalty department' do
        order = order_builder.for_a_book.build
        result = order.process

        expect(result.for_royalty).to eq(:packing_slip)
        expect(result.for_royalty).to be(result.for_shipping)
      end
    end
  end

  context 'Payment is for a membership' do
    it 'activates that membership' do
      order = order_builder.for_membership(:ramon).build
      result = order.process

      expect(result.activated_memberships).to include(:ramon)
    end
  end

  context 'Payment is an upgrade for a membership' do
    it 'apply the upgrade' do
      order = order_builder.for_upgrade_a_membership(:ramon).build
      result = order.process

      expect(result.upgraded_memberships).to include(:ramon)
    end
  end

  context 'Payment is for the video Learning to sky' do
    it 'add a free First Aid to the packing slip' do
      order = order_builder.for_a_video(:learning_to_sky).build
      result = order.process

      expect(result.for_shipping).to eql(:packing_slip_with_free_first_aid)
    end
  end
end
