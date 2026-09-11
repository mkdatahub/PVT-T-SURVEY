-- Migration 06: Support Campaign-Specific Survey Questions
-- Allows campaigns to either use global standard questions or define/customize their own question sets.

-- 1. Add custom_questions JSONB column directly to survey_campaigns for fast and flexible retrieval
ALTER TABLE survey_campaigns 
ADD COLUMN IF NOT EXISTS custom_questions JSONB DEFAULT NULL;

COMMENT ON COLUMN survey_campaigns.custom_questions IS 'Stores custom campaign-specific questions and options array if overridden from standard questions';

-- 2. Optional: Add campaign_id to survey_questions to allow relational mapping
ALTER TABLE survey_questions 
ADD COLUMN IF NOT EXISTS campaign_id UUID REFERENCES survey_campaigns(id) ON DELETE CASCADE;

-- 3. Adjust unique constraint to allow multiple questions per product/respondent_type if linked to different campaigns
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM pg_constraint 
    WHERE conname = 'survey_questions_product_id_respondent_type_question_no_key'
  ) THEN
    ALTER TABLE survey_questions DROP CONSTRAINT survey_questions_product_id_respondent_type_question_no_key;
  END IF;
END $$;

-- Re-create unique constraint accounting for campaign_id (nulls distinct)
ALTER TABLE survey_questions 
ADD CONSTRAINT survey_questions_campaign_product_resp_no_unique 
UNIQUE NULLS NOT DISTINCT (campaign_id, product_id, respondent_type, question_no);
