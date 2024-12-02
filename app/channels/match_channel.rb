class MatchChannel < ApplicationCable::Channel
  def subscribed
    # Stream from a specific match channel (e.g., based on match ID)
    stream_from "match_#{params[:match_id]}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
