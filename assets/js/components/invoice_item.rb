class InvoiceItem
  include Clearwater::Component
  include Clearwater::CachedRender

  attr_reader :invoice

  def initialize invoice
    @invoice = invoice
  end

  # interesting
  #
  # def should_render? previous
  #   !(
  #     invoice.equal?(previous.invoice) &&
  #     editing? == previous.editing?
  #   )
  # end

  def render
    div([
      div({ class_name: 'view' }, [
        label(nil, invoice.name),
        button({ class_name: 'destroy', onclick: method(:delete_invoice) }),
      ])
    ])
  end

  def delete_invoice
    Store.dispatch Actions::DeleteInvoice.new(invoice)
  end

  def handle_edit_key_down event
    case event.code
    when 13 # Enter
      Store.dispatch Actions::RenameInvoice.new(invoice, event.target.value)
    end
  end
end
