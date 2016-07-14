require 'serializers/invoices'

class InvoiceRepository
  include Enumerable

  attr_reader :invoices

  def initialize invoices=load_from_storage
    @invoices = invoices
  end

  def load!
    @invoices = load_from_storage
  end

  def load_from_storage
    InvoicesSerializer.from_json(`localStorage.invoices || '[]'`).invoices
  end

  def save!
    %x{ localStorage.invoices = #{InvoicesSerializer.new(invoices).to_json} }
  end

  def each &block
    invoices.each &block
  end

  def reject! &block
    invoices.reject! &block
    save!
  end

  def << invoice
    invoices << invoice
    save!
  end

  def delete invoice
    invoices.delete invoice
    save!
  end
end
