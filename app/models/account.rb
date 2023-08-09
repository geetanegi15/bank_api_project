class Account < ApplicationRecord

    validates :name, :pin,  presence: true
    validates :amount , numericality: {greater_than: 1000}
    validates :cust_id, presence: true, uniqueness: true
end
