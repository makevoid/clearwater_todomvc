class InvoiceItem
  include Clearwater::Component
  include Clearwater::CachedRender

  attr_reader :invoice

  def initialize invoice, editing
    @invoice = invoice
    @editing = editing
  end

  def should_render? previous
    !(
      invoice.equal?(previous.invoice) &&
      editing? == previous.editing?
    )
  end

  def render
    div([
      div({ class_name: 'view' }, [
        label(nil, invoice.name),
        button({ class_name: 'destroy', onclick: method(:delete_invoice) }),
      ])
    ])
  end

  def toggle_invoice
    Store.dispatch Actions::ToggleInvoice.new(invoice)
  end

  def edit_invoice
    Store.dispatch Actions::EditInvoice.new(invoice)
  end

  def editing?
    @editing
  end

  def done_editing!
    Store.dispatch Actions::DoneEditingInvoice.new(invoice)
  end

  def delete_invoice
    Store.dispatch Actions::DeleteInvoice.new(invoice)
  end

  def handle_edit_key_down event
    case event.code
    when 13 # Enter
      Store.dispatch Actions::RenameInvoice.new(invoice, event.target.value)
      done_editing!
    when 27 # Esc
      done_editing!
    end
  end
end
