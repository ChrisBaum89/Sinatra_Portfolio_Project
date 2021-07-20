class Helpers
  def self.current_user(session)
    @user = User.find_by_id(session[:user_id])
  end

  def self.is_logged_in?(session)
    !!session[:user_id]
  end

  def self.fish_valid(params)
    (params[:fish_species] != "") && (params[:fish_weight] != "") && (params[:fish_length] != "")
  end

  def self.bait_valid(params)
    ((params[:bait_name] != "") && (params[:bait_color] != "") || (params[:bait_id_checked] != nil))
  end

  def self.new_bait(params)
    @bait = Bait.new(name: params["bait_name"], color: params["bait_color"], user_id: session[:user_id])
    @bait.save
  end
end
