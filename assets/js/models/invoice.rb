class Invoice
  attr_reader :id, :name

  def initialize(name, type: "Received")
    @id   = rand
    @name = name
  end

  def update attributes={}
    updated = self.class.new(
      attributes.fetch(:name) { name },
      type: attributes.fetch(:type)
    )
    updated.instance_exec { @id = id }
    updated
  end

  def filtered?
    @name[0] == "a"
  end
end
