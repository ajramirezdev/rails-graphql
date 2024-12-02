class MatchChannel < ApplicationCable::Channel
  def subscribed
    # Stream from a specific match channel (e.g., based on match ID)
    match = Match.find_by(id: params[:match_id])
    stream_for match if match
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
