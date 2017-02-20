class Api::V1::FeedbacksController < ApiController
  def index
    @feedbacks = Solution.where(user_id: params[:user_id]).each do |solution|
      solution.feedbacks.where(status: "unread")
    end
    if !@feedbacks.nil?
      render json: @feedbacks, status: 200
    else 
      render body: nil, status: 400
    end
  end
  
  def show
    @feedback = Feedback.find_by(id: params[:id])
    if !@feedback.nil?
      render json: @feedback, status: 200
    else
      render body: nil, status: 400
    end
  end
end