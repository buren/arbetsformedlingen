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

      # Returns ISCO by local code
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetISCOByLocaleCode
      def isco_by_locale_code(locale_code:)
        client_request('GetISCOByLocaleCode', args: { localeCode: locale_code })
      end

      # Returns ISCO by ISO2 code
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetLanguageIDByISO2Code
      def isco_by_iso2_code(iso2_code:)
        client_request('GetLanguageIDByISO2Code', args: { ISO2Code: iso2_code })
      end

      # Returns locale code by ISCO
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetLocaleCodeByISCO
      def locale_code_by_isco(isco:)
        client_request('GetLocaleCodeByISCO', args: { ISCO: isco })
      end

      # Returns locale fields by locale code
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetLocaleFieldsByLocaleCode
      def locale_fields_by_locale_code(language_id:, locale_code:)
        args = { languageId: language_id, localeCode: locale_code }
        client_request('GetLocaleFieldsByLocaleCode', args: args)
      end

      # Returns locale fields by locale fields
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetLocaleFieldsByLocaleFieldIds
      def locale_fields_by_locale_field_ids(language_id:, locale_field_ids:)
        args = {
          languageId: language_id,
          localeFieldIds: locale_field_ids.map { |id| [:int, id] }
        }
        client_request('GetLocaleFieldsByLocaleFieldIds', args: args)
      end
      # Returns locale fields by text
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetLocaleFieldsByText
      def locale_fields_by_text(language_id:, text:, exact_match: false)
        args = { languageId: language_id, term: text, exactMatch: exact_match }
        client_request('GetLocaleFieldsByText', args: args)
      end

      # Returns locale group by occupation name id
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetLocaleGroupByOccupationNameId
      def locale_group_by_occupation_name_id(language_id:, occupation_name_id:)
        args = { languageId: language_id, occupationNameId: occupation_name_id }
        client_request('GetLocaleGroupByOccupationNameId', args: args)
      end

      # Returns locale group skills by locale code
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetLocaleGroupSkillsByLocaleCode
      def locale_group_skills_by_locale_code(locale_code:)
        args = { localeCode: locale_code }
        client_request('GetLocaleGroupSkillsByLocaleCode', args: args)
      end

      # Returns locale group skills by locale code
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetLocaleGroupsByLocaleCodes
      def locale_groups_by_locale_codes(language_id:, locale_codes:)
        args = {
          languageId: language_id,
          localeCodes: locale_codes.map { |code| [:string, code] }
        }
        client_request('GetLocaleGroupsByLocaleCodes', args: args)
      end

      # Returns locale groups by locale field id
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetLocaleGroupsByLocaleFieldId
      def locale_groups_by_locale_field_id(language_id:, locale_field_id:)
        args = { languageId: language_id, localeFieldId: locale_field_id }
        client_request('GetLocaleGroupsByLocaleFieldId', args: args)
      end

      # Returns locale groups by text
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetLocaleGroupsByText
      def locale_groups_by_text(language_id:, text:, extact_match: false)
        args = { languageId: language_id, term: text, exactMatch: extact_match }
        client_request('GetLocaleGroupsByText', args: args)
      end

      # Returns occupation names for jobs with culture
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetOccupationNamesArt
      def occupation_names_art(language_id:)
        client_request('GetOccupationNamesArt', args: { languageId: language_id })
      end

      # Returns occupation names by locale code
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetOccupationNamesByLocaleCode
      def occupation_names_by_locale_code(language_id:, locale_code:)
        args = { languageId: language_id, localeCode: locale_code }
        client_request('GetOccupationNamesByLocaleCode', args: args)
      end

      # Returns occupation names by locale code
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetOccupationNamesByOccupationNameIds
      def occupation_names_by_occupation_name_ids(language_id:, occupation_name_ids:)
        args = {
          languageId: language_id,
          occupationNameIds: occupation_name_ids.map { |id| [:int, id] }
        }
        client_request('GetOccupationNamesByOccupationNameIds', args: args)
      end

      # Returns occupation names by text
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetOccupationNamesByText
      def occupation_names_by_text(language_id:, text:, extact_match: false)
        args = { languageId: language_id, term: text, exactMatch: extact_match }
        client_request('GetOccupationNamesByText', args: args)
      end

      # Returns occupation names within construction
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetOccupationNamesConstruction
      def occupation_names_construction(language_id:)
        args = { languageId: language_id }
        client_request('GetOccupationNamesConstruction', args: args)
      end

      # Returns occupation names within navigation
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetOccupationNamesNavigation
      def occupation_names_navigation(language_id:)
        args = { languageId: language_id }
        client_request('GetOccupationNamesNavigation', args: args)
      end

      # Returns post codes by municipality
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetPostCodesByNationalNUTSLAU2Code
      def post_codes_by_municipality(language_id:, municipality_id:)
        args = { languageId: language_id, NUTSCode: municipality_id }
        client_request('GetPostCodesByNationalNUTSLAU2Code', args: args)
      end

      # Returns post codes by post code
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetPostCodesByPostCode
      def post_codes_by_post_code(language_id:, post_code:)
        args = { languageId: language_id, postCode: post_code }
        client_request('GetPostCodesByPostCode', args: args)
      end

      # Returns post codes by post locality
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetPostCodesByPostLocality
      def post_codes_by_post_locality(language_id:, post_locality_id:)
        args = { languageId: language_id, postLocalityId: post_locality_id }
        client_request('GetPostCodesByPostLocality', args: args)
      end

      # Returns post codes by post locality
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetSUNField3ByGuide
      def sun_field3_by_guide(language_id:, sun_level1_id:)
        args = { languageId: language_id, SUNLevel1ID: sun_level1_id }
        client_request('GetSUNField3ByGuide', args: args)
      end

      # Returns SUN guide tree
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetSUNGuideTree
      def sun_guide_tree(language_id:)
        client_request('GetSUNGuideTree', args: { languageId: language_id })
      end

      # Returns skill headlines by main headline
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetSkillHeadlinesBySkillMainHeadlineId
      def skill_headlines_by_main_headline(language_id:, skill_main_headline_id:)
        args = { languageId: language_id, skillMainHeadlineId: skill_main_headline_id }
        client_request('GetSkillHeadlinesBySkillMainHeadlineId', args: args)
      end

      # Returns skill headlines by text
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetSkillHeadlinesByText
      def skill_headlines_by_text(language_id:, text:, extact_match: false)
        args = { languageId: language_id, term: text, exactMatch: extact_match }
        client_request('GetSkillHeadlinesByText', args: args)
      end

      # Returns skill main headlines by text
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetSkillMainHeadlinesByText
      def skill_main_headlines_by_text(language_id:, text:, extact_match: false)
        args = { languageId: language_id, term: text, exactMatch: extact_match }
        client_request('GetSkillMainHeadlinesByText', args: args)
      end

      # Returns skills by locale code
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetSkillsByLocaleCode
      def skills_by_locale_code(language_id:, locale_code:)
        # NOTE: Yes there is a typo, "localCode" instead of "localeCode", in the API
        args = { languageId: language_id, localCode: locale_code }
        client_request('GetSkillsByLocaleCode', args: args)
      end

      # Returns skills by main headline
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetSkillsBySkillHeadlineId
      def skills_by_headline(language_id:, skill_headline_id:)
        args = { languageId: language_id, skillHeadlineId: skill_headline_id }
        client_request('GetSkillsBySkillHeadlineId', args: args)
      end

      # Returns skills by skill ids
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetSkillsBySkillIds
      def skills_by_skill_ids(language_id:, skill_ids:)
        args = {
          languageId: language_id,
          skillIds: skill_ids.map { |id| [:int, id] }
        }
        client_request('GetSkillsBySkillIds', args: args)
      end

      # Returns skills versions by skill ids
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetSkillsBySkillIdsVersion
      def skills_versions_by_skill_ids(language_id:, skill_ids:)
        args = {
          languageId: language_id,
          skillIds: skill_ids.map { |id| [:int, id] }
        }
        client_request('GetSkillsBySkillIdsVersion', args: args)
      end

      # Returns skill headlines by main headline
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetSkillsBySkillMainHeadlineId
      def skills_by_main_headline(language_id:, skill_main_headline_id:)
        args = { languageId: language_id, skillMainHeadlineId: skill_main_headline_id }
        client_request('GetSkillsBySkillMainHeadlineId', args: args)
      end

      # Returns skills by text
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetSkillsByText
      def skills_by_text(language_id:, text:, extact_match: false)
        args = { languageId: language_id, term: text, exactMatch: extact_match }
        client_request('GetSkillsByText', args: args)
      end

      # Returns version information
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetVersionInformations
      def version_information
        client_request('GetVersionInformations')
      end
    end
  end
end
