require 'components/invoice_list'

class Layout
  include Clearwater::Component

  def render
    div(nil, [
      div([
        input(
          id: 'new-invoice',
          placeholder: '...',
          onkeydown: method(:handle_new_invoice_key_down),
          autofocus: true
        ),
      ]),

      (outlet || invoice_list),

      footer,
    ])
  end

  def invoice_list
    InvoiceList.new(
      Store.state[:invoices],
      Store.state[:editing_invoices]
    )
  end

  def add_invoice name
    Store.dispatch Actions::AddInvoice.new( Invoice.new name )
  end

  def handle_new_invoice_key_down event
    case event.code
    when 13 # Enter/Return
      add_invoice(event.target.value)
      event.target.clear
    end
  end

  def footer
    active_count = Store.state[:invoices].count &:active?

    ul(nil, [
      li(Link.new({ href: '/' },       'All')),
      li(Link.new({ href: '/active' }, 'Active')),
    ])
  end
end
