require 'zendesk_api'

module TicketHelper
  def client_con
    client = ZendeskAPI::Client.new do |config|

      config.url = ENV['ZENDESK_URL']
      config.username = ENV["ZENDESK_USERNAME"]
      config.token = ENV["ZENDESK_TOKEN"]
      config.retry = true
      config.raise_error_when_rate_limited = false

      require 'logger'
      config.logger = Logger.new(STDOUT)
    end
    return client
  end

  def ticket_save(client, subject, comment, type)
        ticket = ZendeskAPI::Ticket.new(client, :subject => subject, :comment => {:body => comment}, :type => type)
        ticket.save!
  end

  def ticket_intervention(params, requester, battery_id, column_id, elevator_id)
        client = client_con()

        # Fin the customer and get the name of the company
        company_name = Customer.find(params['customer_id']).company_name

        # Condition for check if a employee is assign in the form, else take the author and get the full name using the methode :full_name in the model Employee
        if params[:employees] == nil
            employee_assigns = Intervention.find(params[:author])
        else
            employee_assigns = Employee.find(params[:employees]).full_name
        end

        # Create the fields and format them for the ticket
        subject = "Intervention for #{company_name}"
        comment = "Hello #{employee_assigns}, you have a new intervention for #{company_name}.\nInformations:\n\t - Buidlding_id: #{params['building_id']}\n\t - Battery_id: #{battery_id}"

        # Add the information of column and elevator if exists
        if column_id
            comment += "\n\t - Column_id: #{column_id}"
        end
        if elevator_id
            comment += "\n\t - Elevator_id: #{elevator_id}"
        end
        comment += "\nReport: #{params['report']}\n Cordially\n #{requester}"

        # Save the tickets
        ticket_save(client, subject, comment, "problem")
  end
end