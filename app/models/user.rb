class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #has_many :user_connections,:foreign_key => :followable_id,:foreign_key => :follower_id
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :email, allow_nil: false,  uniqueness: true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates :mobile_number, allow_nil: false,  uniqueness: true, format: { with: /\A\d+\z/, message: "Integer only. No sign allowed." }
  
  validates :name,
    presence: true,
    length: {maximum: 255},
    allow_nil: false

    def self.fetch_all_user(user_id)
      self.where("users.id in ( select user_connections.follower_id from user_connections where user_connections.followable_id = ?)",user_id)
    end

    def self.fetch_details_of_user_transactions(user_id,flag)
      where_clause = flag == 0 ? "ues.paid_by = ? and ues.user_id != ?"  : "ues.paid_by != ? and ues.user_id = ?"
      
      self.select("users.id,users.name,ues.shared_amount,ues.total_amount,exp.name as exp_name")
      .joins("join user_expense_spendings ues on ues.user_id = users.id")
      .joins("join expenses exp on ues.expense_id = exp.id")
      .where("#{where_clause} and ues.transaction_flag = 'pending' ",user_id,user_id)
    end


end
