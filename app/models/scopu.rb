require 'open-uri'

class Scopu < ActiveRecord::Base

  def search(query, protocol_id, max_returned, from, to)

    url = 'http://api.elsevier.com/content/search/scopus?apikey=6d0f623f9844b5c1f1e9f4eeb2ee270a&httpAccept=application%2Fatom%2Bxml&view=COMPLETE&query=' + query + '&date=' + from + '-' + to

    doc = Nokogiri::XML(open(url, 'User-Agent' => 'firefox'))

    doc.xpath("//opensearch:totalResults").each do |entry|
      @total_found = entry.text
    end

    doc.xpath("//xmlns:entry").each do|entry|

      @scopu = Scopu.new

      entry.xpath("./*").each do |element|

        if element.name == 'error'
          # Nenhum resultado retornou da busca
          @results = 0
        else
          if element.name == 'title'
            @scopu.title = element.text
          end
          if element.name == 'creator'
            @scopu.author = element.text
          end
          if element.name == 'description'
            @scopu.abstract = element.text
          end
          if element.name == 'publicationName'
            @scopu.pubtitle = element.text
          end

          if element.name == 'link'
            if element["ref"] == 'scopus'
              @scopu.link = element["href"]
            end
          end

          if element.name == 'coverDate'
            @scopu.year = element.text[0..3]
          end
        end
      end

      @scopu.protocol_id = protocol_id

      @scopu.save!
    end

    unless @results == 0
      @results =  Scopu.where("protocol_id = ?", protocol_id).count
    end

    @reference = Reference.find_or_initialize_by(protocol_id: protocol_id, database_name: 'Scopus')

    @reference.protocol_id = protocol_id
    @reference.database_name = 'Scopus'
    @reference.database = 'scopu'

    @reference.results = @results
    @reference.total_found = @total_found

    @reference.save!
  end

end
