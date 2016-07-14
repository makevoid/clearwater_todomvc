initial_state = {
  invoices: InvoiceRepository.new.load!
}


Store = GrandCentral::Store.new(initial_state) do |state, action|
  puts "ACTION: #{action.class.name}"

  case action
  when Actions::AddInvoice
    state.merge invoices: state[:invoices] + [action.invoice]
  when Actions::DeleteInvoice
    state.merge invoices: state[:invoices] - [action.invoice]
  when Actions::RenameInvoice
    state.merge invoices: state[:invoices].map { |invoice|
      if invoice == action.invoice
        invoice.update name: action.name
      else
        invoice
      end
    }
  when Actions::ClearCompletedInvoices
    state.merge invoices: state[:invoices].reject(&:completed?)
  else
    state
  end
end
