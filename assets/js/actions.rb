require 'grand_central'

module Actions
  include GrandCentral

  AddInvoice = Action.with_attributes :invoice
  ToggleInvoice = Action.with_attributes :invoice
  DeleteInvoice = Action.with_attributes :invoice
  EditInvoice = Action.with_attributes :invoice
  RenameInvoice = Action.with_attributes :invoice, :name
  DoneEditingInvoice = Action.with_attributes :invoice

  ClearCompletedInvoices = Class.new(Action)
  ToggleAllInvoices = Action.with_attributes :completed
end
