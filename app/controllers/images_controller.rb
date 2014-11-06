class ImagesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit, :update, :destroy]

    def index
      @album = Album.find(params[:album_id])
      @images = @album.images.all
    end

    def show
      @album = Album.find(params[:album_id])
      @image = @album.images.find(params[:id])

      respond_to do |format|
        format.html
        format.xml  { render :xml => @image }
      end
    end

    def new
      @album = Album.find(params[:album_id])
      @image = @album.images.build

      respond_to do |format|
        format.html
        format.xml  { render :xml => @image }
      end
    end

    def edit
      @album = Album.find(params[:album_id])
      @image = @album.images.find(params[:id])
    end

    def create
      @album = Album.find(params[:album_id])
      @image = @album.images.create(image_params)

      respond_to do |format|
        if @image.save
          format.html { redirect_to([@image.album, @image], :notice => 'Image was successfully created.') }
          format.xml  { render :xml => @image, :status => :created, :location => [@image.album, @image] }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
        end
      end
    end

    def update
      @album = Album.find(params[:album_id])
      @image = @album.images.find(params[:id])

      respond_to do |format|
        if @image.update_attributes(image_params)
          format.html { redirect_to([@image.album, @image], :notice => 'Image was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /comments/1
    # DELETE /comments/1.json
    def destroy
      @album = Album.find(params[:album_id])
      @image = @album.images.find(params[:id])
      @image.destroy

      respond_to do |format|
        format.html { redirect_to(@album) }
        format.xml  { head :ok }
      end
    end

    def image_params
      params.require(:image).permit(:name, :picture, :album_id, :remote_picture_url)
    end
  end
