require 'models/invoice'
require 'json'

class InvoicesSerializer
  attr_reader :invoices

  def initialize invoices
    @invoices = invoices
  end

  def to_json
    invoices.map { |invoice|
      {
        id: invoice.id,
        name: invoice.name
      }
    }.to_json
  end

  def self.from_json json
    hashes = JSON.parse(json)
    invoices = hashes.map do |hash|
      invoice = Invoice.allocate
      hash.each do |attr, value|
        invoice.instance_variable_set "@#{attr}", value
      end

      invoice
    end

    new(invoices)
  end
end
