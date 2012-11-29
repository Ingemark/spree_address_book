class Spree::AddressesController < Spree::BaseController  
  helper Spree::AddressesHelper
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  
  load_and_authorize_resource
  respond_to :html
  
  def new
    session["user_return_to"] = request.env["HTTP_REFERER"]
  end
  
  def edit
    session["user_return_to"] = request.env["HTTP_REFERER"]
  end

  def create
    @address = Spree::Address.new(params[:address])
    @address.user = spree_current_user
    if @address.save
      respond_with(@address) do |format|
        format.html { redirect_back_or_default(spree.account_path) }
      end
    else
      respond_with(@address)
    end
  end

  def update
    if @address.editable?
      @address.attributes = params[:address]
    else
      @address.update_attribute(:deleted_at, Time.now)
      @address = Spree::Address.new(params[:address])
      @address.user = current_spree_user
    end
    
    if @address.save
      respond_with(@address) do |format|
        format.html { redirect_back_or_default(spree.account_path) }
      end
    else
      respond_with(@address)
    end
  end

  def destroy
    @address.destroy
    respond_with(@address) do |format|
      format.html { redirect_to spree.account_path unless request.xhr? }
    end
  end
end
