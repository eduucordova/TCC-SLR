require 'open-uri'

class Springer < ActiveRecord::Base

  def search(query, protocol_id, max_returned, from, to)

    url = 'http://api.springer.com/metadata/pam?api_key=df81deec5097211838ef3a07c91c02d2&q=year:' + to + '&q=' + query + '&s=1&p=' + max_returned

    doc = Nokogiri::XML(open(url, 'User-Agent' => 'firefox'))

    doc.xpath("//response//result/*").each do|entry|
      if entry.name == 'total'
        @total_found = entry.text
      end
    end

    nextPage = false;

    if (@total_found.to_i > 50 && max_returned.to_i > 50)
      max_returned = (max_returned.to_i - 50).to_s;
      url = 'http://api.springer.com/metadata/pam?api_key=df81deec5097211838ef3a07c91c02d2&q=year:' + to + '&q=' + query + '&s=51&p=' + max_returned
      nextPage = true;
    end

    doc.xpath("//response//records/*").each do|entry|

      @springer = Springer.new

      entry.xpath("./*/*/*").each do |element|

        @springer.abstract = entry.css("p").text

        if element.name == 'title'
          @springer.title = element.text
        end

        if element.name == 'creator'
          @springer.author = element.text
        end

        if element.name == 'publicationName'
          @springer.pubtitle = element.text
        end

        if element.name == 'url'
          @springer.link = element.text
        end

        if element.name == 'publicationDate'
          @springer.year = element.text[0..3]
        end

      end

      @springer.protocol_id = protocol_id
      @springer.save!
    end

    if (nextPage)
      doc = Nokogiri::XML(open(url, 'User-Agent' => 'firefox'))
      doc.xpath("//response//records/*").each do|entry|

      @springer = Springer.new

      entry.xpath("./*/*/*").each do |element|

        @springer.abstract = entry.css("p").text

        if element.name == 'title'
          @springer.title = element.text
        end

        if element.name == 'creator'
          @springer.author = element.text
        end

        if element.name == 'publicationName'
          @springer.pubtitle = element.text
        end

        if element.name == 'url'
          @springer.link = element.text
        end

        if element.name == 'publicationDate'
          @springer.year = element.text[0..3]
        end

      end

      @springer.protocol_id = protocol_id
      @springer.save!
    end
    end

    results =  Springer.where("protocol_id = ?", protocol_id).count

    @reference = Reference.find_or_initialize_by(protocol_id: protocol_id, database_name: 'Springer')

    @reference.protocol_id = protocol_id
    @reference.database_name = 'Springer Link'
    @reference.database = 'springer'

    @reference.results = results
    @reference.total_found = @total_found

    @reference.save!
  end
end
