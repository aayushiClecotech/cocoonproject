class User < ApplicationRecord
	has_many :addresses , inverse_of: :user
	accepts_nested_attributes_for :addresses
end
