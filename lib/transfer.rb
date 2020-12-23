class Transfer
  attr_accessor :status
  attr_reader :receiver, :sender, :amount
  
 
  def initialize(sender, receiver, amount)
    @status = "pending"
    @sender = sender
    @receiver = receiver
    @amount = amount
  end

  def valid?
    sender.valid? && receiver.valid? ? true : false
  end

  def execute_transaction
    if amount > sender.balance || !valid?
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    elsif valid? && status != "complete" 
      sender.balance -= amount
      receiver.balance += amount
      self.status = "complete" 
    end
  end

  def reverse_transfer
    if status == "complete"
      sender.balance += amount
      receiver.balance -= amount
      self.status = "reversed"
    else
      "#{status} transfer cannot be reversed."
    end
  end

end
