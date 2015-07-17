class BidsController < ApplicationController

  def create
    auction = Auction.find params[:auction_id]
    @bid = Bid.new(params.require(:bid).permit([:amount]))
    if auction.user.id != current_user.id && @bid.amount > auction.current_bid
      @bid.auction = auction
      auction.current_bid = @bid.amount
      if @bid.amount < auction.reserve_price
        auction.bid_recieved
      else
        auction.reserve_met
      end
      @bid.user = current_user
      @bid.save
      auction.save
      redirect_to :back
    else
      redirect_to :back, alert: "Invalid Bid"
    end
  end

end
