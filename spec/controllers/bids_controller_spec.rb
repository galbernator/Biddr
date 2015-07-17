require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  describe "#create" do
    before do
      @user = User.create(first_name: "Bill", last_name: "Billerson",
                          email: "me@mail.com", password: "abc",
                          password_confirmation: "abc")
      @auction =  Auction.create(title: "slkdjf", details: "weoiroeiw",
                                 end_date: DateTime.now + 1.day,
                                 reserve_price: 5, user: @user)
    end
    context "user is not signed in" do
      it "redirects to the new sessions path" do
        # post :create, bid: {amount: 100} auction_id: @auction.id
        # expect(response).to redirect_to(new_session_path)
      end
    end

    context "user is signed in" do
      context "with valid params" do
        it "increases the number of bids on the auction by +1" do
          # expect { valid_bid }.to change {Bid.count}
        end
        it "redirects back to the auction page" do
          # expect(response).to redirect_to(auction_path(auction))
        end
      end

      context "with invalid params" do
        it "does not add a bid to the database" do
          # expect { invalid_bid }.to_not change { Bid.count}
        end
        it "renders the auction page" do
          # expect(response).to render(auction_path(auction))
        end

      end

    end


end
