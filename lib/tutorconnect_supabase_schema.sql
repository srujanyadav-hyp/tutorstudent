
-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- -----------------------------
-- USERS TABLE
-- -----------------------------
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    role TEXT CHECK (role IN ('tutor', 'student', 'parent')),
    full_name TEXT NOT NULL,
    email TEXT UNIQUE,
    phone TEXT,
    profile_image TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- -----------------------------
-- TUTORS TABLE
-- -----------------------------
CREATE TABLE IF NOT EXISTS tutors (
    user_id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    expertise TEXT,
    qualifications TEXT,
    experience_years INTEGER,
    pricing NUMERIC,
    created_at TIMESTAMP DEFAULT NOW()
);

-- -----------------------------
-- STUDENTS TABLE
-- -----------------------------
CREATE TABLE IF NOT EXISTS students (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    tutor_id UUID NOT NULL REFERENCES tutors(user_id) ON DELETE CASCADE,
    grade TEXT,
    subjects TEXT,
    parent_id UUID REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- -----------------------------
-- ASSIGNMENTS TABLE
-- -----------------------------
CREATE TABLE IF NOT EXISTS assignments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tutor_id UUID NOT NULL REFERENCES tutors(user_id) ON DELETE CASCADE,
    title TEXT,
    description TEXT,
    due_date TIMESTAMP,
    subject TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- -----------------------------
-- ASSIGNMENT SUBMISSIONS TABLE
-- -----------------------------
CREATE TABLE IF NOT EXISTS assignment_submissions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    assignment_id UUID NOT NULL REFERENCES assignments(id) ON DELETE CASCADE,
    student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    file_url TEXT,
    feedback TEXT,
    grade TEXT,
    submitted_at TIMESTAMP DEFAULT NOW()
);

-- -----------------------------
-- SESSIONS TABLE
-- -----------------------------
CREATE TABLE IF NOT EXISTS sessions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tutor_id UUID NOT NULL REFERENCES tutors(user_id) ON DELETE CASCADE,
    student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    title TEXT,
    scheduled_at TIMESTAMP,
    duration INTEGER,
    meeting_link TEXT,
    status TEXT CHECK (status IN ('upcoming', 'completed', 'cancelled')),
    created_at TIMESTAMP DEFAULT NOW()
);

-- -----------------------------
-- ATTENDANCE TABLE
-- -----------------------------
CREATE TABLE IF NOT EXISTS attendance (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    session_id UUID NOT NULL REFERENCES sessions(id) ON DELETE CASCADE,
    student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    attended BOOLEAN,
    timestamp TIMESTAMP DEFAULT NOW()
);

-- -----------------------------
-- PROGRESS REPORTS TABLE
-- -----------------------------
CREATE TABLE IF NOT EXISTS progress_reports (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    subject TEXT,
    grade TEXT,
    remarks TEXT,
    recorded_at TIMESTAMP DEFAULT NOW()
);

-- -----------------------------
-- MESSAGES TABLE
-- -----------------------------
CREATE TABLE IF NOT EXISTS messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sender_id UUID REFERENCES users(id) ON DELETE CASCADE,
    receiver_id UUID REFERENCES users(id) ON DELETE CASCADE,
    message TEXT,
    file_url TEXT,
    sent_at TIMESTAMP DEFAULT NOW()
);

-- -----------------------------
-- NOTIFICATIONS TABLE
-- -----------------------------
CREATE TABLE IF NOT EXISTS notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    title TEXT,
    body TEXT,
    read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- -----------------------------
-- PAYMENTS TABLE
-- -----------------------------
CREATE TABLE payments (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id uuid REFERENCES users(id) ON DELETE CASCADE,
  tutor_id uuid REFERENCES users(id) ON DELETE CASCADE,
  session_id uuid REFERENCES sessions(id),
  amount numeric(10,2) NOT NULL,
  currency text DEFAULT 'INR',
  status text CHECK (status IN ('pending', 'paid', 'failed')) DEFAULT 'pending',
  payment_method text,
  payment_date timestamp with time zone DEFAULT now(),
  created_at timestamp with time zone DEFAULT now()
);


-- -----------------------------
-- ENABLE RLS ON TABLES
-- -----------------------------
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE tutors ENABLE ROW LEVEL SECURITY;
ALTER TABLE students ENABLE ROW LEVEL SECURITY;
ALTER TABLE assignments ENABLE ROW LEVEL SECURITY;
ALTER TABLE assignment_submissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE attendance ENABLE ROW LEVEL SECURITY;
ALTER TABLE progress_reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;
-- -----------------------------
-- RLS POLICIES
-- -----------------------------

-- USERS
-- Allow users to read and update their own profile
CREATE POLICY "Users access own profile" ON users
FOR SELECT, UPDATE USING (auth.uid() = id);

-- Allow insertion during signup
CREATE POLICY "Allow insert during signup" ON users
FOR INSERT WITH CHECK (auth.uid() = id);

-- TUTORS
CREATE POLICY "Tutor manages own data" ON tutors
FOR ALL USING (auth.uid() = user_id);

-- STUDENTS
CREATE POLICY "Student manages own data" ON students
FOR ALL USING (auth.uid() = user_id);

-- ASSIGNMENTS
CREATE POLICY "Tutor manages own assignments" ON assignments
FOR ALL USING (auth.uid() = tutor_id);

-- ASSIGNMENT SUBMISSIONS
CREATE POLICY "Student accesses own submissions" ON assignment_submissions
FOR SELECT, INSERT, UPDATE USING (auth.uid() = student_id);

-- SESSIONS
CREATE POLICY "Tutor manages own sessions" ON sessions
FOR ALL USING (auth.uid() = tutor_id);

-- ATTENDANCE
CREATE POLICY "Tutor/Student view relevant attendance" ON attendance
FOR SELECT USING (
    EXISTS (
        SELECT 1 FROM students s
        WHERE s.id = attendance.student_id AND auth.uid() IN (s.user_id)
    )
);

-- PROGRESS REPORTS
CREATE POLICY "Student sees their progress" ON progress_reports
FOR SELECT USING (
    EXISTS (
        SELECT 1 FROM students s
        WHERE s.id = progress_reports.student_id AND auth.uid() IN (s.user_id)
    )
);

-- MESSAGES
CREATE POLICY "User sends/receives own messages" ON messages
FOR SELECT, INSERT USING (
    auth.uid() = sender_id OR auth.uid() = receiver_id
);

-- PAYMENTS
CREATE POLICY "User sees own payments" ON payments
FOR SELECT USING (
  auth.uid() = student_id OR auth.uid() = tutor_id
);

-- NOTIFICATIONS
CREATE POLICY "User accesses own notifications" ON notifications
FOR SELECT, UPDATE USING (auth.uid() = user_id);
