class RequestController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:destroy, :update, :edit]

  def index
    @requests = Request.all
  end

  def new
  end

  def show
    codes = ""

    @request = Request.find(params["id"])
    @request.nacebel.each do |nacebel|
      if codes != ""
        codes.concat(',')
      end
      codes.concat(nacebel.code)
    end
    to_send =  JSON.parse(@request.to_json)
    to_send["nacebelCodes"] = codes.split(',')
    to_send = to_send.except(:annualRevenue, :enterpriseNumber, :legalName, :naturalPerson, :nacebelCodes)
    response = HTTParty.post("https://staging-gtw.seraphin.be/quotes/professional-liability", :body => to_send.to_json, :headers => {'Content-Type' => 'application/json',  "X-Api-Key" => "fABF1NGkfn5fpHuJHrbvG3niQX6A1CO53ftF9ASD"})
    @proposal = response["data"]
    @request
  end

  def create
    p '---Check values---'
    p request_params
    return redirect_to request_index_path, alert: "annualRevenue cannot be empty" if request_params["annualRevenue"] == ""
    return redirect_to request_index_path, alert: "enterpriseNumber cannot be empty" if request_params["enterpriseNumber"] == ""
    return redirect_to request_index_path, alert: "enterpriseNumber must have 10 characters" if request_params["enterpriseNumber"].length != 10
    return redirect_to request_index_path, alert: "legalName cannot be empty" if request_params["legalName"] == ""
    return redirect_to request_index_path, alert: "annualRevenue cannot be empty" if request_params["naturalPerson"] == ""
    params["request_nacebel"].delete_if {|nacebel| nacebel == "" }
    return redirect_to request_index_path, alert: "request_nacebel cannot be empty" if params["request_nacebel"] == []
    return redirect_to request_index_path, alert: "annualRevenue cannot be empty" if request_params["naturalPerson"] == ""
    
    request = Request.create(request_params)
    if request.id.nil?
      raise "Erreur inattendue de création de la request"
    end
    # Création des liens request <> nabelcode grâce aux IDS
    #paramstoadd = params["request_nacebel"].drop(1)
    CreateLinks(request.id, params["request_nacebel"])
    # Je dois encore ajouter les codes dans le to_send
    to_send =  JSON.parse(request.to_json)
    # Le front bricolé renvoie un vide dans le array qu'on doit retirer
    #request_nacebel = params["request_nacebel"].drop(1)
    #to_send << request_nacebel
    to_send["nacebelCodes"] = params["request_nacebel"]
    #request << request_nacebel
    to_send = to_send.except(:annualRevenue, :enterpriseNumber, :legalName, :naturalPerson, :nacebelCodes)
    response = HTTParty.post("https://staging-gtw.seraphin.be/quotes/professional-liability", :body => to_send.to_json, :headers => {'Content-Type' => 'application/json',  "X-Api-Key" => "fABF1NGkfn5fpHuJHrbvG3niQX6A1CO53ftF9ASD"})
    respond_to do |format|
      if response.success?
        format.html { redirect_to request_path(request.id), notice: "Request was successfully created." }
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
    params.permit(:email, :phonenumber, :name, :surname, :address, :annualRevenue, :enterpriseNumber, :legalName, :naturalPerson, :user_id)
  end

  def CreateLinks(requestid, nacebelToAdd)
    nacebelToAdd.each do |nacebel|
      nacebelid = Nacebel.find_by(code: nacebel).id
      RequestNacebel.create(request_id: requestid, nacebel_id: nacebelid)
    end
  end
end
