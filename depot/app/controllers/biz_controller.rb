require 'net/http'
require 'xmlsimple'

class BizController < ApplicationController

### i have no idea what i'm doing!
   
  def index
    @biz_search = Hash.new
    @biz_search[:city]     = params[:city]
    @biz_search[:state]    = params[:state]
    @biz_search[:business] = params[:business]
    if params[:commit] == nil
      render :action => 'index'
    else
      if params[:city].nil? || params[:state].nil? || params[:business].nil?
        render :action => 'error_missing_input'
      else
        xml = wp_submit
        puts xml
        parsed_xml = wp_parse(xml)
        if num_search_results(parsed_xml) == 0
          render :action => 'error_no_results'
        else
          @result = wp_result(parsed_xml)
          render :action => 'index'
        end
      end
    end
  end  

### wp api stuff

  def biz_search
    @biz_search
  end

  def userCity
    @biz_search[:city]
  end

  def userState
    @biz_search[:state]
  end

  def userBiz
    @biz_search[:business].downcase.gsub(' ', '+')
  end 

  def wp_submit
    # wp api key for msanjuan
    apiKey = "e827e209ae698228ec5df772b77d1e34"
    
    # url call into wp api
    url = "http://api.whitepages.com/find_business/1.0/?city=#{userCity};state=#{userState};businessname=#{userBiz};api_key=#{apiKey}"

    # get xml
    xml = Net::HTTP.get_response(URI.parse(url)).body
    return xml
  end
    
  def wp_parse(xml)   
    # parse xml
    p = XmlSimple.xml_in(xml)  
    return p
  end

  def num_search_results(parsed_xml)	
    # total no. of search results
    total = parsed_xml['meta'].first['recordrange'].first['wp:totalavailable']
    return total
  end

  def wp_result(parsed_xml)

    result = {}

    # search result biz name
    result[:name] = parsed_xml['listings'].first['listing'].first['business'].first['businessname'].first

    # search result location info
    result[:location] = parsed_xml['listings'].first['listing'].first['address'].first['fullstreet'].first

    # search result biz phone
    bizPhoneAreaCode =  parsed_xml['listings'].first['listing'].first['phonenumbers'].first['phone'].first['areacode'].first
    bizPhonePart1 =  parsed_xml['listings'].first['listing'].first['phonenumbers'].first['phone'].first['exchange'].first
    bizPhonePart2 =  parsed_xml['listings'].first['listing'].first['phonenumbers'].first['phone'].first['linenumber'].first
    result[:phone] = bizPhoneAreaCode + bizPhonePart1 + bizPhonePart2

    return result
  end

end
    
    

