class WelcomeController < ApplicationController

  def index
    @auctions = Auction.all
  end

end
