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

      # Returns occupation names for jobs with culture
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetOccupationNamesArt
      def occupation_names_art(language_id:)
        client_request('GetOccupationNamesArt', args: { languageId: language_id })
      end

      # Returns locale group skills
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllLocaleGroupSkills
      def locale_group_skills
        client_request('GetAllLocaleGroupSkills')
      end

      # Returns locale groups
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllLocaleGroups
      def locale_groups(language_id:)
        client_request('GetAllLocaleGroups', args: { languageId: language_id })
      end

      # Returns locale groups
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllLocaleLevel3
      def locale_level3(language_id:)
        client_request('GetAllLocaleLevel3', args: { languageId: language_id })
      end

      # Returns municipalities
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllMunicipalities
      def municipalities(language_id:)
        client_request('GetAllMunicipalities', args: { languageId: language_id })
      end

      # Returns municipality homepages
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllMunicipalityHomePages
      def municipality_homepages
        client_request('GetAllMunicipalityHomePages')
      end

      # Returns occupation name synonyms
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllOccupationNameSynonyms
      def occupation_name_synonyms(language_id:)
        client_request('GetAllOccupationNameSynonyms', args: { languageId: language_id })
      end

      # Returns occupation name versions
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllOccupationNameSynonyms
      def occupation_name_versions(language_id:)
        client_request('GetAllOccupationNamesVersion', args: { languageId: language_id })
      end

      # Returns post codes
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllPostCodes
      def post_codes(language_id:)
        client_request('GetAllPostCodes', args: { languageId: language_id })
      end

      # Returns post localities
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllPostLocalities
      def post_localities(language_id:)
        client_request('GetAllPostLocalities', args: { languageId: language_id })
      end

      # Returns SNI level 1
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllSNILevel1
      def sni_level1(language_id:)
        client_request('GetAllSNILevel1', args: { languageId: language_id })
      end

      # Returns SNI level 2
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllSNILevel2
      def sni_level2(language_id:)
        client_request('GetAllSNILevel2', args: { languageId: language_id })
      end

      # Returns SUN field 1
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllSUNField1
      def sun_field1(language_id:)
        client_request('GetAllSUNField1', args: { languageId: language_id })
      end

      # Returns SUN field 2
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllSUNField2
      def sun_field2(language_id:)
        client_request('GetAllSUNField2', args: { languageId: language_id })
      end

      # Returns SUN field 3
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllSUNField3
      def sun_field3(language_id:)
        client_request('GetAllSUNField3', args: { languageId: language_id })
      end

      # Returns SUN level 1
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllSUNLevel1
      def sun_level1(language_id:)
        client_request('GetAllSUNLevel1', args: { languageId: language_id })
      end

      # Returns SUN level 2
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllSUNLevel2
      def sun_level2(language_id:)
        client_request('GetAllSUNLevel2', args: { languageId: language_id })
      end

      # Returns SUN level 3
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllSUNLevel3
      def sun_level3(language_id:)
        client_request('GetAllSUNLevel3', args: { languageId: language_id })
      end

      # Returns skill headline
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllSkillHeadlines
      def skill_headlines(language_id:)
        client_request('GetAllSkillHeadlines', args: { languageId: language_id })
      end

      # Returns skill main headline
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllSkillMainHeadlines
      def skill_main_headlines(language_id:)
        client_request('GetAllSkillMainHeadlines', args: { languageId: language_id })
      end

      # Returns skills
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllSkills
      def skills(language_id:)
        client_request('GetAllSkills', args: { languageId: language_id })
      end

      # Returns skill versions
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllSkillsVersion
      def skill_versions(language_id:)
        client_request('GetAllSkillsVersion', args: { languageId: language_id })
      end

      # Returns unemployment benefit societies
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllUnemploymentBenefitSocieties
      def unemployment_benefit_societies(language_id:)
        client_request('GetAllUnemploymentBenefitSocieties', args: { languageId: language_id })
      end

      # Returns unemployment benefit societies
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllWageTypes
      def wage_types(language_id:)
        client_request('GetAllWageTypes', args: { languageId: language_id })
      end

      # Returns work time extents
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllWorkTimeExtents
      def work_time_extents(language_id:)
        client_request('GetAllWorkTimeExtents', args: { languageId: language_id })
      end

      # Returns EU regions by country
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetEURegionsByCountryID
      def eu_regions_by_country(language_id:, country_id:)
        args = { countryId: country_id, languageId: language_id }
        client_request('GetEURegionsByCountryID', args: args)
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
