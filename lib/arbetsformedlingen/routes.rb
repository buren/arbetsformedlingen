module Arbetsformedlingen
  class Routes
    BASE_URL = 'http://api.arbetsformedlingen.se/'.freeze

    # jobs/%{id}
    ROUTES = {
      'version' => 'platsannonser/version',
      'probe' => 'platsannonser/probe'
      # 'search_lan' => 'platsannonser/soklista/lan'
      # 'search_lan2' => 'platsannonser/soklista/lan2'
      # 'search_kommuner' => 'platsannonser/soklista/kommuner?lanid=%{lanid}'
      # 'search_yrkesomraden' => 'platsannonser/soklista/yrkesomraden'
      # 'search_yrkesgrupper' => 'platsannonser/soklista/yrkesgrupper?yrkesomradeid=%{yrkesomradeid}'
      # 'search_yrken_id' => 'platsannonser/soklista/yrken?yrkesgruppid=%{yrkesgruppid}'
      # 'search_yrken' => 'platsannonser/soklista/yrken/%{yrkesnamn}'
      # 'matchning' => 'platsannonser/matchning?lansid={M}&kommunid={M}&yrkesid={M}&nyckelord={M}&sida={V}&antalrader={V}'
      # 'annons' => 'platsannonser/{:annonsid *}'
      # 'annons_logo' => 'platsannonser/{:annonsid *}/logotyp'
    }.freeze

    attr_reader :routes, :base_url

    def self.draw(name, **args)
      new.draw(name, **args)
    end

    def initialize
      @routes = ROUTES
      @base_url = BASE_URL
    end

    def draw(name, **args)
      base_url + routes.fetch(name.to_s) % args
    end
  end
end
