class AuctionsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new(auction_params)
    @auction.user = current_user
    @auction.current_bid = 0
    if @auction.save
      redirect_to auction_path(@auction)
    else
      render :new
    end
  end

  def show
    @auction = Auction.find(params[:id])
    @bid = Bid.new
    @bids = Bid.where(auction: @auction).order(:amount).reverse
  end

  def edit
    @auction = Auction.find(params[:id])
  end

  def update
    @auction = Auction.find(params[:id])
    if @auction.update(auction_params)
      redirect_to auction_path(@auction)
    else
      render :edit
    end
  end

  def destroy
    auction = Auction.find(params[:id])
    auction.destroy
    redirect_to user_path(current_user)
  end

  private

  def auction_params
    params.require(:auction).permit([:title, :details, :end_date, :reserve_price])
  end
end
