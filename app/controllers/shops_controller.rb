class ShopsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_shop, only: [:show, :edit, :update, :destroy]

  def index
    

    @shops = Shop.all

     if params[:category].blank?
  	@shops = Shop.all
    else
      @category_id = Category.find_by(name: params[:category]).id
      @shops = Shop.where(:category_id => @category_id)
   end
  end

  def show
    session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        customer_email: current_user.email,
        line_items: [{
            name: @shop.title,
            description: @shop.description,
            amount: @shop.price * 100,
            currency: 'aud',
            quantity: 1,
        }],
        payment_intent_data: {
            metadata: {
                user_id: current_user.id,
                listing_id: @shop.id
            }
        },
        success_url: "#{root_url}payments/success?userId=#{current_user.id}&listingId=#{@shop.id}",
        cancel_url: "#{root_url}listings"
    )

    @session_id = session.id
   
  	
  end


  def new
  	@shop = current_user.shops.create
     @categories = Category.all.map{ |c| [c.name, c.id]}
  	
  end

  def create

  	@shop = current_user.shops.build(shop_params)
     @shop.category_id = params[:category_id]
  	if @shop.save
  		redirect_to root_path
  	else

  		render 'new'

  	end
  end

    def edit
      @categories = Category.all.map{ |c| [c.name, c.id] }
    end


  	def update
       @shop.category_id = params[:category_id] 
      @shop = Shop.update(params["id"], shop_params)
       if @shop.update(shop_params)
        redirect_to root_path
        else
          render 'edit'
      end
    end

    def destroy
      Shop.find(params[:id]).destroy
      redirect_to root_path
      
    end


  


  private

  def find_shop
  	@shop =Shop.find(params[:id])
  	
  end



  def shop_params

  	params.require(:shop).permit(:title, :description, :price, :category_id, :image, :color, :search)

  end
  
end
