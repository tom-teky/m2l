class Transaction < ActiveRecord::Base
	belongs_to :src_account, class_name: 'Account'
  belongs_to :dst_account, class_name: 'Account'
end
