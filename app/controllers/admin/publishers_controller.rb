class Admin::PublishersController < ApplicationController
  before_action :set_publisher, only: [:show, :edit, :update, :destroy]

  # GET /admin/publishers
  # GET /admin/publishers.json
  def index
    @publishers = Publisher.all
  end

  # GET /admin/publishers/1
  # GET /admin/publishers/1.json
  def show
  end

  # GET /admin/publishers/new
  def new
    @publisher = Publisher.new
  end

  # GET /admin/publishers/1/edit
  def edit
  end

  # POST /admin/publishers
  # POST /admin/publishers.json
  def create
    @publisher = Publisher.new(publisher_params)

    respond_to do |format|
      if @publisher.save
        format.html { redirect_to [:admin, @publisher], notice: 'Publisher was successfully created.' }
        format.json { render action: 'show', status: :created, location: @publisher }
      else
        format.html { render action: 'new' }
        format.json { render json: @publisher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/publishers/1
  # PATCH/PUT /admin/publishers/1.json
  def update
    respond_to do |format|
      if @publisher.update(publisher_params)
        format.html { redirect_to [:admin, @publisher], notice: 'Publisher was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @publisher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/publishers/1
  # DELETE /admin/publishers/1.json
  def destroy
    @publisher.destroy
    respond_to do |format|
      format.html { redirect_to admin_publishers_url, notice: 'Publisher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publisher
      @publisher = Publisher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publisher_params
      params.require(:publisher).permit(:name)
    end
end
