class SkinsController < ApplicationController
  # GET /skins
  # GET /skins.xml
  before_filter :login_required, :only => [ :edit, :update, :destroy ]
  def index
    @skins = Skin.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @skins }
    end
  end

  # GET /skins/1
  # GET /skins/1.xml
  def show
    @skin = Skin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @skin }
    end
  end

  # GET /skins/new
  # GET /skins/new.xml
  def new
    @skin = Skin.new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @skin }
    end
  end

  # GET /skins/1/edit
  def edit
    @skin = Skin.find(params[:id])
  end

  def create_next
    logger.error "stage==#{params[:stage]}"
  end
  # POST /skins
  # POST /skins.xml
  def create
    @skin = Skin.new(params[:skin])
    #set the price
    @skin.price=1
    @image = Image.new(params[:image])
    Skin.transaction do
      @image.skin=@skin
      @skin.save!
      @image.save!
      respond_to do |format|
        
        flash[:notice] = 'Skin was successfully created.'
        format.html { redirect_to(@skin) }
        format.xml  { render :xml => @skin, :status => :created, :location => @skin }
      end
    end
  
    # format.html { render :action => "new" }
    # format.xml  { render :xml => @skin.errors, :status => :unprocessable_entity }
  end
      


  # PUT /skins/1
  # PUT /skins/1.xml
  def update
    @skin = Skin.find(params[:id])

    respond_to do |format|
      if @skin.update_attributes(params[:skin])
        flash[:notice] = 'Skin was successfully updated.'
        format.html { redirect_to(@skin) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @skin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /skins/1
  # DELETE /skins/1.xml
  def destroy
    @skin = Skin.find(params[:id])
    @skin.destroy

    respond_to do |format|
      format.html { redirect_to(skins_url) }
      format.xml  { head :ok }
    end
  end
end
