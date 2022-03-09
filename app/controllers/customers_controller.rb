require 'csv'

class CustomersController < ApplicationController
  def index
  end

  def upload
    begin
      if params[:file].nil? or params[:sort].nil?
        raise "Please select a file and sort type."
      end

      # determine delim
      content = File.read(params[:file])
      if content.include? ","
        delim = ","
      elsif content.include? "|"
        delim = "|"
      else
        raise "File must be comma- or pipe-delimited."
      end

      # parse file
      rows = []
      CSV.parse(content, col_sep: delim) do |row|
        if row.count != 6
          raise "File does not contain all required columns."
        end
        currRow = {
          firstName: row[0],
          lastName: row[1],
          email: row[2],
          vehicleType: row[3],
          vehicleName: row[4],
          vehicleLength: row[5]
        }
        rows << currRow
      end

      # all sorting is case-insensitive
      if params[:sort] == "vehicle_type"
        # secondary sort by full name
        rows.sort_by!{ |hsh| [hsh[:vehicleType].downcase, "#{hsh[:lastName]} #{hsh[:firstName]}".downcase] }
      elsif params[:sort] == "full_name"
        rows.sort_by!{ |hsh| "#{hsh[:lastName]} #{hsh[:firstName]}".downcase }
      end
      render :json => {results: rows}
    rescue StandardError => e
      render :json => {error: e.message}
    end
  end
end
