require 'components/invoice_item'

class InvoiceList
  include Clearwater::Component
  include Clearwater::CachedRender

  attr_reader :invoices

  def initialize invoices
    @invoices = invoices
  end

  def render
    section({ id: 'main' }, [
      ul({ id: 'invoice-list' }, invoice_items),
    ])
  end

  def invoice_items
    invoices.map { |invoice|
      li({ key: invoice.id, class_name: "invoice" }, [
        InvoiceItem.new(invoice)
      ])
    }
  end
end
