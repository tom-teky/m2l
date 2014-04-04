class Account < ActiveRecord::Base
  has_many :transactions
  
  before_create :init_balance

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def can_perform_a_transaction?
    balance.to_i > 0
  end

  def transact_to!(dst_account, amount)
    ActiveRecord::Base.transaction do 
      self.balance = -amount + self.balance.to_i
      dst_account.balance = amount + dst_account.balance.to_i

      self.save!
      dst_account.save!
      Transaction.create(amount: amount, src_account_id: self.to_param, dst_account_id: dst_account.to_param)
    end
  end

  protected

  def init_balance
  	self.balance = 100
  end

end
