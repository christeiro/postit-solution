module Voteable
  extend ActiveSupport::Concern

  included do
  	has_many :votes, as: :votable
  end

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