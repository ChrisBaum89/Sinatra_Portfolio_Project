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

  def self.new_bait(params, user_id)
    @bait = Bait.new(name: params["bait_name"], color: params["bait_color"], user_id: user_id.id)
    @bait.save
    @bait
  end

  def self.catch_fish_info(catch, params)
    @catch = catch
    @catch.fish.species = params[:fish_species]
    @catch.fish.weight = params[:fish_weight]
    @catch.fish.length = params[:fish_length]
  end

  def self.new_fish(catch, session, params)
    @catch = catch
    @fish = Fish.new(species: params["fish_species"], weight: params["fish_weight"], length: params["fish_length"], catch_id: @catch.id)
    @fish.save
    @fish
  end

end
