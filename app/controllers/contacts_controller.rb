class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
    render json: {status: 200, contacts: @contacts}
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = @current_user.contacts.new(contact_params)
    if @contact.save
      render json: {status: 201, contact: @contact}
    else
      render json: {status: 400}
    end
  end

  # PATCH/PUT /contacts/1.json
  def update
    if @contact.update(contact_params)
      render json: {status: 200, contact: @contact}
    else
      render json: {status: 400}
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    render json: {status: 204}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, :phone, :email)
    end
    
    def authenticate_user
      token = AuthToken.find_by(token: request.headers['HTTP_AUTHORIZATION'])
      render json: {status: 401, error: 'no token or wrong token', token: request.headers['HTTP_AUTHORIZATION']} unless token
      @current_user = token.user
    end
end
