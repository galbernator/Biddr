require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do

  describe '#new' do
    it "assigns an instance variable @auction" do
      get :new
      expect(assigns(:auction)).to be_a_new Auction
    end
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe '#new' do
    context "user is not signed in" do
      it "redirects to the sign in page" do
        post :create
        expect(response).to redirect_to new_session_path
      end
    end
  end

  context "user is signed in" do
      before do
        @user = User.create(first_name: "Bill", last_name: "Billerson",
                            email: "me@mail.com", password: "abc",
                            password_confirmation: "abc")
      end

      def valid_auction
        post :create, auction: Auction.create(title: "slkdjf", details: "weoiroeiw",
                                              end_date: DateTime.now + 1.day,
                                              reserve_price: 5, user: @user)
      end
      context "with valid parameters" do
        it "changes the auction count by +1" do
            expect { valid_auction }.to change { Auction.count }.by(1)
        end
        # it "redirects to the auction's show page" do
        #   valid_auction
        #   expect(response).to redirect_to auction_path(Auction.last)
        # end
        it "associates the auciton with the signed in user"do
          valid_auction
          expect(Auction.last.user).to eq(@user)
        end
      end

      context "with invalid parameters" do

        def invalid_auction
          post :create, auction: Auction.create(title: nil, details: nil,
                                                end_date: nil, reserve_price: nil)
        end
        # it "renders the new template again" do
        #   invalid_auction
        #   expect(response).to render_template(:new)
        # end
        it "does not create a new acution" do
          expect { invalid_auction }.to_not change { Auction.count }
        end
      end
    end
 end
