class RequestController < ApplicationController
  def index
    @requests = Request.all
  end

  def new
  end

  def show
    @request = Request.find(params["id"])
  end

  def receive
    p '--receive--'
    request = Request.create(request_params)
    # Création des liens request <> nabelcode grâce aux IDS
    paramstoadd = params["request_nacebel"].drop(1)
    CreateLinks(request.id, paramstoadd)
    # Je dois encore ajouter les codes dans le to_send
    to_send =  JSON.parse(request.to_json)
    # Le front bricolé renvoie un vide dans le array qu'on doit retirer
    request_nacebel = params["request_nacebel"].drop(1)
    #to_send << request_nacebel
    to_send["nacebelCodes"] = request_nacebel
    #request << request_nacebel
    to_send = to_send.except(:annualRevenue, :enterpriseNumber, :legalName, :naturalPerson, :nacebelCodes)
    response = HTTParty.post("https://staging-gtw.seraphin.be/quotes/professional-liability", :body => to_send.to_json, :headers => {'Content-Type' => 'application/json',  "X-Api-Key" => "fABF1NGkfn5fpHuJHrbvG3niQX6A1CO53ftF9ASD"})
    p '--response : --'
    p response
    p '--before respond_to--'
    respond_to do |format|
      if response.success?
        format.html { redirect_to request_index_url, notice: "Request was successfully created." }
        format.json { render :json => response}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    request = Request.find(params["id"])

    RequestNacebel.where(request_id: params["id"]).destroy_all
    Request.find(params["id"]).destroy

    respond_to do |format|
      format.html { redirect_to request_index_url, notice: "Request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private 
  # Only allow a list of trusted parameters through.
  def request_params
    params.permit(:email, :phonenumber, :name, :surname, :address, :annualRevenue, :enterpriseNumber, :legalName, :naturalPerson)
  end

  def CreateLinks(requestid, nacebelToAdd)
    nacebelToAdd.each do |nacebel|
      nacebelid = Nacebel.find_by(code: nacebel).id
      RequestNacebel.create(request_id: requestid, nacebel_id: nacebelid)
    end
  end
end
