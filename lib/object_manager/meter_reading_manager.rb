class MeterReadingManager < ObjectManager	
  
  def self.create(user, params)
    # params hash:
    #   service_id
    #   place_id
    #   prev_reading
    #   meter_reading:
    #    id
    #    field_id
    #    reading
    #    snapshot_url

    is_init = params[:prev_reading] ? false : true

    meter_reading_params = {
    						            service_id:   params[:service_id],
    						            reading: 		  params[:meter_reading][:reading],
    						            field_id: 		params[:meter_reading][:field_id],
    						            user_id: 		  user.id,
    						            is_init: 		  is_init
    					             }

    meter_reading = MeterReading.create!(meter_reading_params)

  	if params[:snapshot]
        snapshot_url = save_snapshot(user, params[:snapshot], meter_reading.created_at, params[:service_id])
        meter_reading.update_attribute(:snapshot_url, snapshot_url)
    end

    unless is_init
      account = ServiceManager.get(params[:service_id]).account
      field = FieldManager.get(params[:meter_reading][:field_id])
      amount = calculate_amount(params[:meter_reading][:reading].to_f, params[:prev_reading].to_f, field.value)
      updater = AmountUpdater.new(account)
      updater.increase_by(amount)
      account.update_attribute(:status, -1) if account.amount > 0.0
    end
    return meter_reading
  end    

  def self.get_by_vendor(month, vendor_id)
    meter_readings = MeterReading.where("extract(month from created_at) = ?", month).select("snapshot_url, reading, created_at, service_id, field_id")
    meter_readings_array = []
    meter_readings.each do |mr|
      service = ServiceManager.get(mr.service_id)
      if service.vendor_id.to_i == vendor_id.to_i
        mr[:field_title] = FieldManager.get(mr[:field_id]).title
        mr[:user_account] = service.user_account
        meter_readings_array << mr
      end
    end
  end

	def self.get_by_tariff(tariff)
		tariff.meter_readings
	end

  def self.get_last(field_id)
      MeterReading.where(field_id: field_id).order("created_at DESC").limit(1).first
  end

  def self.reset(params, user)
    account = ServiceManager.get(params[:service_id]).account
    if ServiceManager.get(params[:service_id]).meter_readings
      MeterReading.delete_all(['service_id = ? and user_id = ?', params[:service_id], user.id])
    end
    AmountUpdater.new(account).nullify
    AccountManager.update_status(account)
  end

  def self.delete_last(params, user)
    account = ServiceManager.get(params[:service_id]).account
    if ServiceManager.get(params[:service_id]).meter_readings
      MeterReading.delete(self.get_last(params[:field_id]).id)
    end
    AmountUpdater.new(account).nullify
    AccountManager.update_status(account)
  end

  def self.create_init(params, user)
    meter_reading_params = {
                            service_id:   params[:service_id],
                            reading:      params[:reading],
                            field_id:     params[:field_id],
                            user_id:      user.id,
                            is_init:      true
                           }

    MeterReading.create!(meter_reading_params)
  end

  protected

  def self.calculate_amount(current_value, old_value, field_value)
  	amount = (current_value - old_value)*field_value
  end

  def self.save_snapshot(user, snapshot, snapshot_name, service_id)
    snapshot_name = snapshot_name.to_datetime
  	name = snapshot_name.to_s(:number)+'.png'
  	directory = File.join('/','home','ubuntu','apps','shared','images','meter_reading_snapshots', user.id.to_s, service_id.to_s)

  	unless File.directory?(directory)
  	  FileUtils.mkdir_p(directory)
  	end

  	path = File.join(directory, name)
  	File.open(path, "wb") { |f| f.write(snapshot.read) }
  	directory = File.join('/','home','ubuntu','apps','shared','images','meter_reading_snapshots', user.id.to_s, service_id.to_s)
  	path = File.join(directory, name)
  	path = "images/meter_reading_snapshots/#{user.id}/#{service_id}/#{name}"
    path
  end
end