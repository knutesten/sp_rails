class ProtocolsController < ApplicationController
  before_action :set_protocol, only: [:show, :edit, :update, :destroy]

  # GET /protocols
  # GET /protocols.json
  def index
    @protocols = Protocol.all
  end

  # GET /protocols/1
  # GET /protocols/1.json
  def show
  end

  # GET /protocols/new
  def new
    @users = User.all
    @protocol = Protocol.new
  end

  # GET /protocols/1/edit
  def edit
  end

  # POST /protocols
  # POST /protocols.json
  def create
    @protocol = Protocol.new
    @users = User.all

    @protocol = Protocol.new protocol_params
    @protocol.valid?
    if not params.has_key? :debtors or (params[:debtors].one? and params[:debtors].values.first == current_user.id.to_s)
      @protocol.errors[:debtors] = 'You must set at least one debtor other than yourself.'
    end

    if @protocol.errors.empty?
      debtors = params.require(:debtors)
      create_protocol_for_each_debtor debtors, protocol_params
    end

    respond_to do |format|
      if @protocol.errors.empty?
        format.html { redirect_to new_protocol_path, notice: 'Protocols were successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

# PATCH/PUT /protocols/1
# PATCH/PUT /protocols/1.json
  def update
    respond_to do |format|
      if @protocol.update(protocol_params)
        format.html { redirect_to @protocol, notice: 'Protocol was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

# DELETE /protocols/1
# DELETE /protocols/1.json
  def destroy
    @protocol.destroy
    respond_to do |format|
      format.html { redirect_to protocols_url, notice: 'Protocol was successfully destroyed.' }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_protocol
    @protocol = Protocol.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def protocol_params
    params.require(:protocol).permit(:ware, :price, :amount_owed)
  end

  def create_protocol_for_each_debtor(debtors, protocol_params)
    if valid_debtors? debtors
      debtors.each_key do |debtor_key|
        protocol = Protocol.new protocol_params
        protocol.buyer = current_user
        protocol.debtor_id = debtors[debtor_key]
        protocol.amount_owed = protocol_params[:price].to_f / debtors.length
        protocol.save
      end
    end
  end

  def valid_debtors? (debtors)
    debtors.each_value do |id|
      unless User.exists? id
        return false
      end
    end
  end
end
