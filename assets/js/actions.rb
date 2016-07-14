require 'grand_central'

module Actions
  include GrandCentral

  AddInvoice    = Action.with_attributes :invoice
  ToggleInvoice = Action.with_attributes :invoice
  DeleteInvoice = Action.with_attributes :invoice

  FilterInvoices = Action.with_attributes :completed
end
