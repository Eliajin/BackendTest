class ResultController < ApplicationController
  def result
    @request = Request.all
  end
end
