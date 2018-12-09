# frozen_string_literal: true

require 'arbetsformedlingen/api/base_soap_client'

module Arbetsformedlingen
  module API
    # WsOccupation API client
    # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx
    class TaxonomyClient < BaseSOAPClient
      # Service URL
      SERVICE_URL = 'http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx'

      # Namespace
      NAMESPACE = 'urn:ams.se:Taxonomy'

      # Initialize client
      def initialize
        super(SERVICE_URL, NAMESPACE)
      end

      # Returns occupation names
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllOccupationNames
      def occupation_names(language_id:)
        client_request('GetAllOccupationNames', args: { languageId: language_id })
      end

      # Returns AID occupation names
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllAIDOccupationNames
      def aid_occupation_names
        client_request('GetAllAIDOccupationNames')
      end

      # Returns continents
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllContinents
      def continents(language_id:)
        client_request('GetAllContinents', args: { languageId: language_id })
      end

      # Returns countries
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllCountries
      def countries(language_id:)
        client_request('GetAllCountries', args: { languageId: language_id })
      end

      # Returns drivers_licenses
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllDrivingLicences
      def drivers_licenses(language_id:)
        client_request('GetAllDrivingLicences', args: { languageId: language_id })
      end

      # Returns eu regions
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllEURegions
      def eu_regions(language_id:)
        client_request('GetAllEURegions', args: { languageId: language_id })
      end

      # Returns employment durations
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllEmploymentDurations
      def employment_durations(language_id:)
        client_request('GetAllEmploymentDurations', args: { languageId: language_id })
      end

      # Returns employment durations
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllEmploymentTypes
      def employment_types(language_id:)
        client_request('GetAllEmploymentTypes', args: { languageId: language_id })
      end

      # Returns experiences last
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllExperiencesLast
      def experiences_last(language_id:)
        client_request('GetAllExperiencesLast', args: { languageId: language_id })
      end

      # Returns experiences year
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllExperiencesYear
      def experiences_year(language_id:)
        client_request('GetAllExperiencesYear', args: { languageId: language_id })
      end

      # Returns AIDO occupation names
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAIDOccupationNameByLabel
      def aido_occupation_names(label:)
        client_request('GetAIDOccupationNameByLabel', args: { label: label })
      end

      # Returns internal job situations
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllInternalJobSituations
      def internal_job_situations
        client_request('GetAllInternalJobSituations')
      end

      # Returns job situations
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllJobSituations
      def job_situations(language_id:)
        client_request('GetAllJobSituations', args: { languageId: language_id })
      end

      # Returns language_levels
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllLanguageLevels
      def language_levels(language_id:)
        client_request('GetAllLanguageLevels', args: { languageId: language_id })
      end

      # Returns languages
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllLanguages
      def languages(language_id:)
        client_request('GetAllLanguages', args: { languageId: language_id })
      end

      # Returns languages with ISO
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllLanguagesWithISO
      def languages_with_iso(language_id:)
        client_request('GetAllLanguagesWithISO', args: { languageId: language_id })
      end

      # Returns locale fields
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllLanguagesWithISO
      def locale_fields(language_id:)
        client_request('GetAllLocaleFields', args: { languageId: language_id })
      end

      # Returns municipalities
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllMunicipalities
      def municipalities(language_id:)
        client_request('GetAllMunicipalities', args: { languageId: language_id })
      end

      # Returns occupation names for jobs with culture
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetOccupationNamesArt
      def occupation_names_art(language_id:)
        client_request('GetOccupationNamesArt', args: { languageId: language_id })
      end

      # Returns SUN guide tree
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetSUNGuideTree
      def sun_guide_tree(language_id:)
        client_request('GetSUNGuideTree', args: { languageId: language_id })
      end
    end
  end
end