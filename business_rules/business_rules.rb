
describe 'Order processing application' do
  context 'Payment is for a physical product' do
    it 'generates a packing slip for shipping' do
      order = :physical_product
      expect(OPA.register_payment(order).for_shipping).to eq(:packing_slip)
      expect(OPA.register_payment(order).for_royalty).to be_nil
    end

    context 'When the payment is for a book' do
      it 'creates a duplicated packing slip for the royalty department' do
        order = :book
        expect(OPA.register_payment(order).for_royalty).not_to be_nil
        expect(OPA.register_payment(order).for_royalty).to be(OPA.register_payment(order).for_shipping)
      end
    end
  end

  context 'Payment is for a membership' do
    it 'activates that membership' do
      order = :membership
      expect(OPA.register_payment(order).activated).to include(:membership)
    end
  end
end

class OPA
  class << self
    def register_payment(order)
      builder = ResultBuilder.new
      apply_book_royalty_rule(order, builder)
      activate_memberships(order, builder)
      builder.build
    end

    private

    def apply_book_royalty_rule(order, builder)
      if order == :book
        builder.duplicate_for_shipping
      end
    end

    def activate_memberships(order, builder)
      if order == :membership
        builder.mark_as_activated(order)
      end
    end
  end
end

class ResultBuilder
  def initialize
    @for_shipping = :packing_slip
    @activated = []
  end

  def build
    attributes = {
      for_royalty: @for_royalty,
      for_shipping: @for_shipping,
      activated: @activated
    }
    Result.new(attributes)
  end

  def duplicate_for_shipping
    @for_royalty = @for_shipping
  end

  def mark_as_activated(membership)
    @activated.push(membership)
  end
end

class Result
  def initialize(attributes)
    @for_shipping = attributes[:for_shipping]
    @for_royalty = attributes[:for_royalty]
    @activated = attributes[:activated]
  end

  attr_reader :for_shipping, :for_royalty, :activated
end
