module Jekyll
  class LocationChild < Generator
    safe true
    priority :highest

    def generate(site)
      events = site.collections["events"]
      events.docs.each do |event|
        location = self.location(site, event.data["location"])
        if location
          location.data["addr_html"] = self.address(location)
          event.data["locobj"] = location
        end
      end
    end

    def address(location)
      address = ""
      if defined? location.data["subtitle"]
        address += "#{location.data["subtitle"]}<br/>"
      end
      if defined? location.data["address"]
        address += "\n#{location.data["address"]}<br/>"
      end
      if defined? location.data["address1"]
        address += "\n#{location.data["address1"]}<br/>"
      end
      if defined? location.data["city"]
        address += "\n#{location.data["city"]}"
      end
      if defined? location.data["state"]
        address += ", #{location.data["state"]}"
      end
      if defined? location.data["zip"]
        address += " #{location.data["zip"]}"
      end
      return address
    end

    def location(site, name)
      locations = site.collections["locations"]
      locations.docs.each do |l|
        if l.data["title"] == name
          puts l.data["title"]
          return l
        end
      end
      return nil
    end

  end
end
