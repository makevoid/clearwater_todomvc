require 'components/invoice_list'

class InvoiceFilteredList < InvoiceList
  def invoices
    super.select(&:active?)
  end
end

# Paid Invoices
# Sent Invoices
# Receivables Invoices
# Offered Invoices
# ...
