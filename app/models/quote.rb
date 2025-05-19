class Quote < ApplicationRecord
  belongs_to :user
  belongs_to :source

  attr_accessor :fname, :lname,:byear, :dyear, :bio,:catname
  has_many :quote_categories, dependent: :destroy
  has_many :categories, through: :quote_categories
end

