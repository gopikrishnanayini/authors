class ImagesController < ApplicationController
  def index
    @image = Image.all
  end

	def new
    @image = Image.new
    render "add_new"
	end

 def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to :back, success: 'File successfully uploaded'
    else
      flash.now[:notice] = 'There was an error'
      render :add_new
    end
  end

  def update
    redirect_to images_path
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
      redirect_to images_path
  end

	protected

  def image_params
    params.require(:image).permit!
  end
end
