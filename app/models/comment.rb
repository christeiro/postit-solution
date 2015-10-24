class Comment < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post
  has_many :votes, as: :votable
  
  validates :body, presence: true

  def total_votes
  	positive_votes - negative_votes
  end

  def positive_votes
  	self.votes.where(vote: true).size
  end

  def negative_votes
  	self.votes.where(vote: false).size
  end
end