class Public::CustomersController < ApplicationController
  def show
    @genres = Genre.only_active
    @customer = current_customer
  end

  def edit
    @genres = Genre.only_active
    @customer = current_customer
  end
  
  def update
    if @customer.update(customer_params)
      redirect_to mypage_path
    else
      render :edit
    end
  end
  
  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :email, :postal_code, :adress, :telephone_number)
  end

end
