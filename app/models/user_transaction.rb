class UserTransaction < ApplicationRecord
    validates :user_id,:allow_blank => false
    validates :expense_id,:allow_blank => false
    validates :paid_amount,:allow_nil => false
end
