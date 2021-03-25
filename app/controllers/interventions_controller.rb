class InterventionsController < ApplicationController
  # POST /quotes or /quotes.json
  
  def get_building_by_customer_list
    @interventions = Intervention.where("customer_id = ?", params[:customer_id])
    respond_to do |format|
      format.json { render :json => @interventions }
    end
  end
  
  def building_search
    if params[:customers].present? && params[:customers].strip != ""
      @interventions = Intervention.where("customer_id = ?", params[:customer_id])
    else
      @interventions = Intervention.all
    end
  end
  
  
  
  def create
    #===================================================================================================
    # DECLARING VARIABLES  
    #===================================================================================================
    @interventions= Intervention.new()
    @interventions.author = current_user.id
    # @interventions.author = Employee.find_by(user_id: current_user.id)
    @interventions.battery_id = params[:battery]
    @interventions.building_id = params[:buildings]
    @interventions.column_id = params[:columns]
    @interventions.customer_id = params[:customers]
    @interventions.elevator_id = params[:elevators]
    @interventions.employee_id = params[:employees]
    @interventions.start_of_intervention = params[:start_of_intervention]
    @interventions.end_of_intervention = params[:end_of_intervention]
    @interventions.result = params[:result]
    @interventions.report = params[:report]
    @interventions.status = "Pending"
    #===================================================================================================
    # SAVE AND REDIRECT
    #===================================================================================================
    @interventions.save

    if @interventions.save!
      # Redirect back to page
      redirect_back fallback_location: root_path, notice: "Intervention sucessfull"
    end 
    #===================================================================================================
    # PRINTS PARAMS INTO TERMINAL WINDOW
    #===================================================================================================
    puts "===========START================"
    puts params
    puts "=============END================"
  end    


  # Only allow a list of trusted parameters through.
  def intervention_params
    #===================================================================================================
    # CAPTURES DATA FROM SUBMITTED FORMS
    #===================================================================================================
    params.require(:interventions).permit(
      :author, :battery_id, :building_id, :column_id, :customer_id, :elevator_id, :employee_id,
      :start_of_intervention, :end_of_intervention, :result, :report, :status 
    )
    
  end
end
