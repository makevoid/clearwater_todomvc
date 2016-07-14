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
      if editing?
        input(
          class_name: 'edit',
          default_value: invoice.name,
          onkeydown: method(:handle_edit_key_down),
          autofocus: true,
        )
      else
        div({ class_name: 'view' }, [
          input(
            class_name: 'toggle',
            type: 'checkbox',
            checked: invoice.completed?,
            onchange: method(:toggle_invoice),
          ),
          label({ ondblclick: method(:edit_invoice) }, invoice.name),
          button({ class_name: 'destroy', onclick: method(:delete_invoice) }),
        ])
      end,
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
