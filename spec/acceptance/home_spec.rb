require 'acceptance_helper'

resource	'主页获取活动信息' do
	header "Accept", "application/json"

	get '/home_info' do

    before do
     	create(:activity, first_phase_begin: "2016-10-1 00:00:00",
     										third_phase_end: "2016-12-30 00:00:00")
    end

    example "主页查询 最后一次活动信息" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end

    describe '活动未开始' do
    	before do 
    		create(:activity, first_phase_begin: "2016-12-1 00:00:00",
     										third_phase_end: "2016-12-30 00:00:00")
  		end
  		example "当前时间不在 最后一次活动的上线时间内" do
	      do_request
	      puts response_body
	      expect(status).to eq(200)
    	end
  	end

	end	
end	