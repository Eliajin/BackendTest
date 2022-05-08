class RequestController < ApplicationController
  def form
  end

  def show
    form
  end

  def receive
    p '--receive--'
    request = Request.create(request_params)
    p 'request'
    to_send =  request.to_json
    p to_send
    p 'post-httparty'
    response = HTTParty.post("https://staging-gtw.seraphin.be/quotes/professional-liability", :body => to_send, :headers => {'Content-Type' => 'application/json',  "X-Api-Key" => "fABF1NGkfn5fpHuJHrbvG3niQX6A1CO53ftF9ASD"})
    p 'response'
    p response
    p '--end-receive--'
    request
  end


  private 
  # Only allow a list of trusted parameters through.
  def request_params
    params.permit(:email, :phonenumber, :name, :surname, :address, :annualRevenue, :enterpriseNumber, :legalName, :naturalPerson)
  end
end
