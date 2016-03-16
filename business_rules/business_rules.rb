class OrderBuilder
  def initialize
    @attributes = {
      product: nil,
      type: nil,
      name: nil
    }
  end

  def for_physical_product
    @attributes[:type] = :physical

    self
  end

  def for_a_book
    @attributes[:product] = :book
    @attributes[:type] = :physical

    self
  end

  def for_membership(name)
    @attributes[:product] = :membership
    @attributes[:name] = name

    self
  end

  def for_upgrade_a_membership(name)
    @attributes[:name] = name
    @attributes[:product] = :upgrade

    self
  end

  def for_a_video(name)
    @attributes[:name] = name
    @attributes[:product] = :video
    @attributes[:type] = :physical

    self
  end

  def build
    Order.new(@attributes)
  end
end

class Order
  def initialize(product:, type:, name:)
    @product = product
    @type = type
    @name = name
  end

  attr_reader :product, :type, :name

  def process
    Processors.new.process(self)
  end
end

class Processors
  def initialize
    @processors = [
      Book.new,
      Upgrade.new,
      Membership.new,
      Video.new
    ]
  end

  def process(order)
    @processors.each_with_object(Result.new) do |processor, result|
      processor.process(order, result)
    end
  end
end

class Processor
  def process(order, result)
    raise 'should be implemented in a sub class'
  end
end

class Book < Processor
  def process(order, result)
    return unless order.product == :book

    result.duplicate_shipping_for_royalty
  end
end

class Membership < Processor
  def process(order, result)
    return unless order.product == :membership

    result.activate_membership(order.name)
  end
end

class Upgrade < Processor
  def process(order, result)
    return unless order.product == :upgrade

    result.upgrade_a_membership(order.name)
  end
end

class Video < Processor
  def process(order, result)
    return unless order.product == :video && order.name == :learning_to_sky

    result.for_shipping_with_free_aid
  end
end

class Result
  def initialize
    @for_shipping = :packing_slip
    @for_royalty = nil
    @activated_memberships = []
    @upgraded_memberships = []
  end

  attr_reader :activated_memberships
  attr_reader :upgraded_memberships
  attr_reader :for_shipping
  attr_reader :for_royalty

  def duplicate_shipping_for_royalty
    @for_royalty = @for_shipping
  end

  def for_shipping_with_free_aid
    @for_shipping = :packing_slip_with_free_first_aid
  end

  def activate_membership(name)
    @activated_memberships << name
  end

  def upgrade_a_membership(name)
    @upgraded_memberships << name
  end
end
