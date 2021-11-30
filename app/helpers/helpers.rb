class Helpers

  #return current user
  def self.current_user(session)
    @user = User.find_by_id(session[:user_id])
  end

  #return true if a session is active
  def self.is_logged_in?(session)
    !!session[:user_id]
  end

  #return true if all Fish model attributes are present in the params
  def self.fish_valid(params)
    (params[:fish_species] != "") && (params[:fish_weight] != "") && (params[:fish_length] != "")
  end

  #return true if all Bait model attributes are present in the params
  def self.bait_valid(params)
    ((params[:bait_name] != "") && (params[:bait_color] != "") || (params[:bait_id_checked] != nil))
  end

  #simplifies new Bait mass assignment
  def self.new_bait(params, user_id)
    @bait = Bait.create(name: params["bait_name"], color: params["bait_color"], user_id: user_id.id)
    @bait
  end

  def self.catch_fish_info(catch, params)
    @catch = catch
    @catch.fish.species = params[:fish_species]
    @catch.fish.weight = params[:fish_weight]
    @catch.fish.length = params[:fish_length]
  end

  def self.existing_bait_valid(params)
    existing_bait_good = (params[:bait_id_checked] != "") && (params[:bait_id_checked] != nil)
    new_bait_empty = (params[:bait_name] == "") && (params[:bait_color] == "")
    existing_bait_good && new_bait_empty
  end

  def self.new_bait_valid(params)
    (params[:bait_id_checked] == nil) && (params[:bait_name] != "") && (params[:bait_color] != "")
  end

end
