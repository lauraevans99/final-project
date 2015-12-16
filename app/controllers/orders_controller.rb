class OrdersController < ApplicationController

	def destroy
	  current_order.destroy
	  session[:order_id] = nil
	  redirect_to root_path, :notice => "Basket emptied successfully."
	end

	def checkout
	  @order = Shoppe::Order.find(current_order.id)

	  if request.patch?
	  		puts "in patch"
	  		p @order
	    if @order

	      puts "in patch2"
	      # @order.proceed_to_confirm(params[:order].permit(:first_name, :last_name, :billing_address1, :billing_address2, :billing_address3, :billing_address4, :billing_country_id, :billing_postcode, :email_address, :phone_number))
	      @params = params[:order].permit(:first_name, :last_name, :billing_address1, :billing_address2, :billing_address3, :billing_address4, :billing_country_id, :billing_postcode, :email_address, :phone_number)
	      @order.update(@params)

	      p @order
	      puts "BREAK............."
	      p @order.order_items
	      puts "in patch3"

	      redirect_to checkout_payment_path
	    end
	  end
	end

	def payment
	  @order = Shoppe::Order.find(current_order.id)
	  p @order
	  if request.post?
	    if @order.accept_stripe_token(params[:stripe_token])
	    	p @order
	      redirect_to checkout_confirmation_path
	    else
	      flash.now[:notice] = "Could not exchange Stripe token. Please try again."
	    end
	  end
	end

	def confirmation
	  if request.post?
	  	p @order
	    current_order.confirm!
	    session[:order_id] = nil
	    redirect_to root_path, :notice => "Order has been placed successfully!"
	  end
	end

end
