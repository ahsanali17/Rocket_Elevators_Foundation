class RecognizersController < ApplicationController
    before_action :set_test, only: %i[ show edit update destroy ]
  
    # GET /tests or /tests.json
    def index
      @Recognizer = Recognizer.all
    end
  
    # GET /tests/1 or /tests/1.json
    def show
    end
  
    # GET /tests/new
    def new
      @Recognizer = Recognizer.new
    end
  
    # GET /tests/1/edit
    def edit
    end
  
    # POST /tests or /tests.json
    def create
      @Recognizer = Recognizer.new(recognizer_params)
  
      respond_to do |format|
        if @Recognizer.save
          format.html { redirect_to @Recognizer, notice: "Test was successfully created." }
          format.json { render :show, status: :created, location: @Recognizer }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @Recognizer.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /tests/1 or /tests/1.json
    def update
      respond_to do |format|
        if @Recognizer.update(recognizer_params)
          format.html { redirect_to @Recognizer, notice: "Test was successfully updated." }
          format.json { render :show, status: :ok, location: @Recognizer }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @Recognizer.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /tests/1 or /tests/1.json
    def destroy
      @Recognizer.destroy
      respond_to do |format|
        format.html { redirect_to Recognizers_url, notice: "Test was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_Recognizer
        @Recognizer = Recognizer.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def Recognizer_params
        params.fetch(:recognizer, {})
      end
  end
  