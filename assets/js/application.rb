require 'opal'
require 'clearwater'
require 'grand_central'
require 'set'

require 'components/layout'
require 'components/invoice_filtered_list'
require 'components/invoice_list_wrapper'
require 'repositories/invoice'
require 'actions'
require 'store'

router = Clearwater::Router.new do
  route 'filtered' => InvoiceListWrapper.new(InvoiceFilteredList) # Sent / Received / On Offer / Financed
end

App = Clearwater::Application.new(
  component: Layout.new,
  router: router,
  element: Bowser.document['#invoiceapp']
)

Store.on_dispatch do |old, new|
  unless old.equal? new
    InvoiceRepository.new(Store.state[:invoices]).save!
    App.render
  end
end

App.call
