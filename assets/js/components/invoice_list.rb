require 'components/invoice_item'

class InvoiceList
  include Clearwater::Component
  include Clearwater::CachedRender

  attr_reader :invoices, :editing_invoices

  def initialize invoices, editing_invoices
    @invoices = invoices
    @editing_invoices = editing_invoices
  end

  def should_render? previous
    !(
      invoices.equal?(previous.invoices) &&
      editing_invoices.equal?(previous.editing_invoices)
    )
  end

  def render
    section({ id: 'main' }, [
      input(
        id: 'toggle-all',
        type: 'checkbox',
        onchange: method(:toggle_all),
        checked: invoices.all? { |t| t.completed? },
      ),
      ul({ id: 'invoice-list' }, invoice_items),
    ])
  end

  def toggle_all event
    Store.dispatch Actions::ToggleAllInvoices.new event.target.checked?
  end

  def invoice_items
    invoices.map { |invoice|
      editing = editing_invoices.include?(invoice)

      li({ key: invoice.id, class_name: invoice_class(invoice.completed?, editing) }, [
        InvoiceItem.new(invoice, editing)
      ])
    }
  end

  def invoice_class completed, editing
    [
      ('completed' if completed),
      ('editing' if editing),
    ].compact.join(' ')
  end
end
