class InterventionsController < ApplicationController
  # POST /quotes or /quotes.json
 
  def getData
    params = request.query_parameters{"id"}
    # field = request.query_parameters{"value"}
    puts "**********Id & Field***************"
    puts params 
    puts "**********----------**********"

    @data = " "

    if params[:value] == "building"  
      @data = Building.where(customer_id: params[:id])
    elsif  params[:value] == "battery"
      @data = Battery.where(building_id: params[:id])
    elsif  params[:value] == "column"
      @data = Column.where(battery_id: params[:id])
    elsif  params[:value] == "elevator"
      @data = Elevator.where(column_id: params[:id]) 
    else
      @data = " "
    end

    puts "************Data****************"
    puts @data
    puts "************----**************"

    return render json: @data 

  end
 

  def create
   
    #===================================================================================================
    # DECLARING VARIABLES  
    #===================================================================================================
    @interventions= Intervention.new()
    @interventions.author = current_user.id
    # @interventions.author = Employee.find_by(user_id: current_user.id)
    @interventions.battery_id = params[:batteries] unless params[:columns] !=nil 
    @interventions.building_id = params[:buildings] 
    @interventions.column_id = params[:columns] unless params[:elevators] !=nil
    @interventions.customer_id = params[:customers]
    @interventions.elevator_id = params[:elevators] 
    @interventions.employee_id = params[:employees]
    @interventions.start_of_intervention = params[:start_of_intervention]
    @interventions.end_of_intervention = params[:end_of_intervention]
    @interventions.report = params[:report]
    @interventions.result = params[:result]
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

    #===================================================================================================
    # So null ID's will not be required 
    #===================================================================================================
    # if @interventions.elevator_id
    #   @interventions.battery_id = nil
    #   @interventions.column_id = nil
    # elsif @interventions.column_id
    #   @interventions.battery_id = nil
    # end  

    #===================================================================================================
    # Defining the ZendDesk ticket for the interventions form
    #===================================================================================================

    # def create_intervention_ticket  
    #   client = ZendeskAPI::Client.new do |config|
    #     config.url = ENV['ZENDESK_URL']
    #     config.username = ENV['ZENDESK_USERNAME']
    #     config.token = ENV['ZENDESK_TOKEN']
    #   end

    #   ZendeskAPI::Ticket.create!(client,
    #     :subject => "#{@interventions.customer_id}",
    #     :comment => {
    #       :value =>
    #      "Customer Details: The contact name #{@interventions.author}, from the company #{@customer.company_name} has filled out an intervention form \n
    #       Building ID: #{@interventions.building_id} \n
    #       Battery ID: #{@interventions.battery_id} \n
    #       Column ID: #{@interventions.column_id}
    #       Elevators ID: #{@interventions.elevator_id} \n
    #       The assigned employee to the task is: #{@interventions.author} \n
    #       Description/Report: #{@interventions.report}" 
    #     }
        
    #     :requester => {
    #       "name": @interventions.company_name,  
    #       "email": @interventions.email
    #     },
      
    #     :type => "problem", 
    #     :priority => "Urgent"      
    #   )
    
    # end  


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
