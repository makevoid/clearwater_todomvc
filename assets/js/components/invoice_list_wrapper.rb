InvoiceListWrapper = Struct.new(:component_class) do
  include Clearwater::Component

  def render
    component_class.new(Store.state[:invoices])
  end
end
