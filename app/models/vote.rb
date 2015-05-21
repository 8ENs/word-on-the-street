class Vote < ActiveRecord::Base
  belongs_to :track
  has_many :user
end