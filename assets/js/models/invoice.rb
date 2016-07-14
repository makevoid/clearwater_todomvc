class Invoice
  attr_reader :id, :name

  def initialize(name, completed: false)
    @id = rand
    @name = name
    @completed = completed
  end

  def completed?
    !!@completed
  end

  def active?
    !completed?
  end

  def update attributes={}
    updated = self.class.new(
      attributes.fetch(:name) { name },
      completed: attributes.fetch(:completed) { completed? }
    )
    updated.instance_exec { @id = id }
    updated
  end

  def toggled completed=!completed?
    update completed: completed
  end

  def toggle! value=!completed?
    @completed = value
  end
end
