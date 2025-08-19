-- Remove parent-related artifacts safely

-- 1) Drop parent-related helper functions if they exist
DROP FUNCTION IF EXISTS get_parent_upcoming_sessions(uuid);
DROP FUNCTION IF EXISTS get_parent_billing_stats(uuid);
DROP FUNCTION IF EXISTS get_parent_recent_activities(uuid);

-- From parent/student linking feature
DROP FUNCTION IF EXISTS get_parent_students(uuid);
DROP FUNCTION IF EXISTS link_student(uuid, text);
DROP FUNCTION IF EXISTS unlink_student(uuid, uuid);

-- 2) Drop parent-related tables if they exist
-- Legacy link tables
DROP TABLE IF EXISTS parent_students CASCADE;
DROP TABLE IF EXISTS parent_student_links CASCADE;

-- 3) Remove parent references on core tables
-- students.parent_id (no longer used)
DO $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM information_schema.columns
    WHERE table_schema = 'public'
      AND table_name   = 'students'
      AND column_name  = 'parent_id'
  ) THEN
    ALTER TABLE public.students DROP COLUMN parent_id;
  END IF;
END
$$ LANGUAGE plpgsql;

-- billing.parent_id and parent policies
DO $$
BEGIN
  -- Drop the parent-specific policy on billing if present
  IF EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'public'
      AND tablename  = 'billing'
      AND policyname = 'Parents can see their own billing'
  ) THEN
    DROP POLICY "Parents can see their own billing" ON public.billing;
  END IF;

  -- Drop parent_id column if it exists
  IF EXISTS (
    SELECT 1
    FROM information_schema.columns
    WHERE table_schema = 'public'
      AND table_name   = 'billing'
      AND column_name  = 'parent_id'
  ) THEN
    ALTER TABLE public.billing DROP COLUMN parent_id;
  END IF;

  -- Ensure students can see their own billing (if table retained)
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'public'
      AND tablename  = 'billing'
      AND policyname = 'Students can see their own billing'
  ) THEN
    CREATE POLICY "Students can see their own billing"
      ON public.billing FOR ALL
      USING (auth.uid() = student_id);
  END IF;
END
$$ LANGUAGE plpgsql;

-- 4) Note: user_profiles.role CHECK still allows 'parent'. We leave it for
-- backward compatibility; having extra enum value does not impact behavior.
-- If you want to strictly enforce only student/tutor, we can add a follow-up
-- migration to redefine the constraint safely with downtime scheduling.
